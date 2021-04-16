require 'rails_helper'

RSpec.describe "store_locators/edit", type: :view do
  before(:each) do
    @store_locator = assign(:store_locator, StoreLocator.create!())
  end

  it "renders the edit store_locator form" do
    render

    assert_select "form[action=?][method=?]", store_locator_path(@store_locator), "post" do
    end
  end
end
