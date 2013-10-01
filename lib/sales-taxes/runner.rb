module SalesTaxes

  class Runner
    def initialize
    end

    def run
      app = App.new
    end
  end

  class App

    attr_accessor :baskets

    # provide a string of items
    def create_basket items_string
      @baskets = Array.new if @baskets.nil?
      basket = SalesTaxes::Basket.new items_string
      @baskets << basket
      basket
    end

  end

  class Basket
    attr_accessor :items

    def initialize items_string
      self.parse_items items_string
    end

    def parse_items items_string
      array_of_item_hashes = SalesTaxes::Item.parse_item_string(items_string)

      @items = Array.new
      array_of_item_hashes.each do |item_hash|
        item_object = SalesTaxes::Item.new item_hash
        @items.push item_object
      end

      @items
    end

    def create_receipt
      # total items
      self.calculate_totals

      # print receipt
      self.format_receipt
    end

    def calculate_totals
      # tell each item to calcuate its total_price
      @items.each do |item|
        item.calculate_total_price_and_taxes
      end
    end

    # Need a receipt like this:
    # Output 1:
    # 1 book : 12.49
    # 1 music CD: 16.49
    # 1 chocolate bar: 0.85
    # Sales Taxes: 1.50
    # Total: 29.83
    def format_receipt
      receipt = ''

      @items.each do |item|
        receipt +=  item.generate_receipt_string
        receipt += "\n"
      end

      sales_taxes = 0.00
      @items.each do |item|
        sales_taxes +=  item.total_tax
      end

      total = 0.00
      @items.each do |item|
        total +=  item.total_price
      end

      receipt += "Sales Taxes: " + sprintf("%.2f",sales_taxes)
      receipt += "\n"
      receipt += "Total: " + sprintf("%.2f",total)
      receipt
    end
  end

  class Item

    REGULAR_TAX_PERCENT = 10
    IMPORT_TAX_PERCENT = 5
    REGULAR_TAX_EXEMPT_ITEMS = ['book', 'books', 'chocolate', 'pill', 'chocolates']
    ROUNDING_FRACTION = 0.05

    attr_accessor :price, :type, :quantity, :total_price, :total_tax, :item_hash

    def self.parse_item_string(items_string)
        begin
        items_string_array_formatted = Array.new
        items_string_array = items_string.split(/\r?\n/)
        items_string_array.each do |item_string|
          # remove beginning whitespace
          item_string = item_string.lstrip

          item_hash = Hash.new
          # split string into words, the first word is the quantity, convert to integer
          quantity_string = item_string.split.first
          item_hash[:quantity] = quantity_string.to_i

          # take the last word as the price, convert into float
          price_string = item_string.split.last
          item_hash[:price] = price_string.to_f

          # and the type is the item_string, without the quantity, price, & 'at', without beginning or endiing spaces
          quantity_and_type_with_at = item_string.split(price_string).first
          # get rid of quanitiy & remove white space
          type_with_at = quantity_and_type_with_at.split(quantity_string).last.strip
          # remove the 'at'
          item_hash[:type] = type_with_at.split(' at').first.strip

          items_string_array_formatted.push item_hash
        end

        items_string_array_formatted
      rescue
        # items_string_array_formatted = []
        raise 'Poorly formatted items string'
      end
    end

    def initialize(args=nil)
      args.each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end unless args.nil?
    end

    def is_exempt_from_regular_tax?
      REGULAR_TAX_EXEMPT_ITEMS.any? {|word| self.type.include?(word)}
    end

    def is_exempt_from_import_tax?
      !self.type.include? 'imported'
    end

    # looks if its an import tax only item
    # figures out total tax and updates total price_price
    def calculate_total_price_and_taxes
      # find the tax rate
      tax_rate_percent = 0

      unless is_exempt_from_regular_tax?
        tax_rate_percent += REGULAR_TAX_PERCENT
      end

      unless self.is_exempt_from_import_tax?
        tax_rate_percent += IMPORT_TAX_PERCENT
      end

      # np/100
      # total tax needs to be a float rounded to nearest .05
      @total_tax = SalesTaxes::Item.round_properly((self.price * tax_rate_percent)/100)

      @total_price = (@price + @total_tax)
    end

    # return a string of the item in final receipt format
    # ex: 1 chocolate bar: 0.85
    def generate_receipt_string
      "#{@quantity} #{type}: #{sprintf("%.2f",total_price)}"
    end

    # takes in an unrounded float, returned float rounded to nearest .05
    def self.round_properly(float)
      mulitplier = (float/ROUNDING_FRACTION).ceil
      (mulitplier * ROUNDING_FRACTION)
    end

  end

end

  # takes input
  # need to parse out key variables...


  # what are we calculating

  # adding items
  # way to provide items, items need to have name, price
  # given that we have a list of items, we need to add them

  # texes...

  # item ... quantitiy, name, price with tax, total_tax

  # some items are exempt... so we need to check if it's exempt

# PROBLEM TWO: SALES TAXES
 
# Basic sales tax is applicable at a rate of 10% on all goods, except books, food, and medical products that are exempt. Import duty is an additional sales tax applicable on all imported goods at a rate of 5%, with no exemptions.
 
# When I purchase items I receive a receipt which lists the name of all the items and their price (including tax), finishing with the total cost of the items, and the total amounts of sales taxes paid.  The rounding rules for sales tax are that for a tax rate of n%, a shelf price of p contains (np/100 rounded up to the nearest 0.05) amount of sales tax.
 
# Write an application that prints out the receipt details for these shopping baskets...
# INPUT:
 
# Input 1:
# 1 book at 12.49
# 1 music CD at 14.99
# 1 chocolate bar at 0.85
 
# Input 2:
# 1 imported box of chocolates at 10.00
# 1 imported bottle of perfume at 47.50
 
# Input 3:
# 1 imported bottle of perfume at 27.99
# 1 bottle of perfume at 18.99
# 1 packet of headache pills at 9.75
# 1 box of imported chocolates at 11.25
 
# OUTPUT
 
# Output 1:
# 1 book : 12.49
# 1 music CD: 16.49
# 1 chocolate bar: 0.85
# Sales Taxes: 1.50
# Total: 29.83
 
# Output 2:
# 1 imported box of chocolates: 10.50
# 1 imported bottle of perfume: 54.65
# Sales Taxes: 7.65
# Total: 65.15
 
# Output 3:
# 1 imported bottle of perfume: 32.19
# 1 bottle of perfume: 20.89
# 1 packet of headache pills: 9.75
# 1 imported box of chocolates: 11.85
# Sales Taxes: 6.70
# Total: 74.68