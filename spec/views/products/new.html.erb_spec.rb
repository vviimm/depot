require 'rails_helper'

RSpec.describe "products/new", type: :view do
  before(:each) do
    assign(:product, Product.new(
      :title => "MyString",
      :description => "MyText",
      :image_url => "image.jpg",
      :price => "9.99"
    ))
  end

  it "renders new product form" do
    render

    assert_select "form[action=?][method=?]", products_path, "post" do

      assert_select "input#product_title[name=?]", "product[title]"

      assert_select "textarea#product_description[name=?]", "product[description]"

      assert_select "input#product_image_url[name=?]", "product[image_url]"

      assert_select "input#product_price[name=?]", "product[price]"
    end
  end
end
