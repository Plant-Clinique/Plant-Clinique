require "rails_helper"

RSpec.describe UserPlantsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/user_plants").not_to be_routable
    end

    it "routes to #new" do
      expect(get: "/user_plants/new").to route_to("user_plants#new")
    end

    it "routes to #show" do
      expect(get: "/user_plants/1").to route_to("user_plants#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/user_plants/1/edit").to route_to("user_plants#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/user_plants").to route_to("user_plants#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/user_plants/1").to route_to("user_plants#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/user_plants/1").to route_to("user_plants#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/user_plants/1").to route_to("user_plants#destroy", id: "1")
    end
  end
end
