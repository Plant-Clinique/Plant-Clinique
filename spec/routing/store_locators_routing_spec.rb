require "rails_helper"

RSpec.describe StoreLocatorsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/store_locators").to route_to("store_locators#index")
    end

    it "routes to #new" do
      expect(get: "/store_locators/new").to route_to("store_locators#new")
    end

    it "routes to #show" do
      expect(get: "/store_locators/1").to route_to("store_locators#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/store_locators/1/edit").to route_to("store_locators#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/store_locators").to route_to("store_locators#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/store_locators/1").to route_to("store_locators#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/store_locators/1").to route_to("store_locators#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/store_locators/1").to route_to("store_locators#destroy", id: "1")
    end
  end
end
