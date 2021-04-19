require 'rails_helper'

RSpec.describe "store_locators/index", type: :view do
  before(:each) do
    assign(:store_locators, [
      StoreLocator.create!(),
      StoreLocator.create!()
    ])
  end

  it "renders a list of store_locators" do
    render
  end
end
