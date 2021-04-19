require 'rails_helper'

RSpec.describe "store_locators/show", type: :view do
  before(:each) do
    @store_locator = assign(:store_locator, StoreLocator.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
