class App

  def calculate(input)
  end

  # parse
  # string:string
  # formatted array of items
  def parse(items_string)
    items_string_array_formatted = Array.new
    items_string_array = items_string.split(/\r?\n/)
    items_string_array.each do |item_string|
      # remove beginning whitespace
      item_string = item_string.lstrip

      item_hash = Hash.new
      item_hash[:quantity] = item_string.split(' ')[0]
      item_hash[:type] = ''
      item_hash[:price] = ''
      items_string_array_formatted.push item_hash
    end

    items_string_array_formatted
  end

end

class Basket
  def add_item(quantitiy=1)

  end
end

class Item

  attr_accessor :price, :tax_rate

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