require_relative '../../lib/sales-taxes/runner'

describe SalesTaxes::App do

  it "processes input 1 properly" do
    input =
"1 book at 12.49
1 music CD at 14.99
1 chocolate bar at 0.85"

    expected_output =
"1 book: 12.49
1 music CD: 16.49
1 chocolate bar: 0.85
Sales Taxes: 1.50
Total: 29.83"

    app = SalesTaxes::App.new
    basket = app.create_basket input

    output = basket.create_receipt
    output.should == expected_output
  end

  it "processes input 2 properly" do
    input =
"1 imported box of chocolates at 10.00
1 imported bottle of perfume at 47.50"

    expected_output =
"1 imported box of chocolates: 10.50
1 imported bottle of perfume: 54.65
Sales Taxes: 7.65
Total: 65.15"

    app = SalesTaxes::App.new
    basket = app.create_basket input

    output = basket.create_receipt
    output.should == expected_output
  end

  it "processes input 3 properly" do
    input =
"1 imported bottle of perfume at 27.99
1 bottle of perfume at 18.99
1 packet of headache pills at 9.75
1 box of imported chocolates at 11.25"

    expected_output =
"1 imported bottle of perfume: 32.19
1 bottle of perfume: 20.89
1 packet of headache pills: 9.75
1 box of imported chocolates: 11.85
Sales Taxes: 6.70
Total: 74.68"

    app = SalesTaxes::App.new
    basket = app.create_basket input

    output = basket.create_receipt
    output.should == expected_output
  end

#   describe "#calculate_receipt" do
#     it "calculates output correctly" do
#       input =
# "1 book at 12.49
# 1 music CD at 14.99
# 1 chocolate bar at 0.85"

#       expected_output =
# "1 book: 12.49
# 1 music CD: 16.49
# 1 chocolate bar: 0.85
# Sales Taxes: 1.50
# Total: 29.83"

#       app = SalesTaxes::App.new
#       output = app.calculate_receipt(input)
#       output.should == expected_output
#     end
#   end

  # describe "#parse_items" do
  #   it "should convert a input string to a properly formatted array" do
  #     input =
  #       "1 book at 12.49
  #       1 music CD at 14.99
  #       1 chocolate bar at 0.85"

  #     expected_array_of_items = [
  #       {:quantity => 1, :type => 'book', :price => 12.49},
  #       {:quantity => 1, :type => 'music CD', :price => 14.99},
  #       {:quantity => 1, :type => 'chocolate bar', :price => 0.85}
  #     ]

  #     app = SalesTaxes::App.new
  #     array_of_items = app.parse_items(input)
  #     array_of_items.should == expected_array_of_items
  #   end
  # end

  # describe "#calculate_total_price_for_item" do
  #   context "a correctly formatted item hash for item with taxes" do

  #     before(:each) do
  #       @app = SalesTaxes::App.new
  #       @item_hash = {:quantity => 1, :type => 'music CD', :price => 14.99}
  #     end

  #     it "should find the total price for item" do
  #       total_price = @app.calculate_total_price_for_item(@item_hash)
  #       total_price.should == 17.24
  #     end
  #   end

  #   context "a correctly formatted item hash for item with only import taxes" do

  #     before(:each) do
  #       @app = SalesTaxes::App.new
  #       @item_hash = {:quantity => 1, :type => 'chocolate bar', :price => 0.85}
  #     end

  #     it "should find the total price for item" do
  #       total_price = @app.calculate_total_price_for_item(@item_hash)
  #       total_price.should == 0.89
  #     end
  #   end
  # end

end

  # describe "Input 1" do
  # end

  # describe "Input 2" do
  # end

  # describe "Input 2" do
  # end



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
