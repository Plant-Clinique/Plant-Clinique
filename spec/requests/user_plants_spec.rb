 require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/user_plants", type: :request do
  
  # User.create!(username: "one", email: "two@one.com", password:"three")
  # UserPlant.create!(user_id: User.first.id,
  #                   name: 'smol plant',
  #                   age: 1)

  # UserPlant. As you add validations to UserPlant, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # Depends on user being signed in: 
  # describe "GET /new" do
  #   it "renders a successful response" do
  #     get new_user_plant_url
  #     expect(response).to be_successful
  #   end
  # end

  describe "GET /edit" do
    it "render a successful response" do
      user_plant = UserPlant.create!( user_id: User.first.id,
                                      name: 'smol plant',
                                      age: 1)
      get edit_user_plant_url(user_plant)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new UserPlant" do
        expect {
          post user_plants_url, params: { user_plant: valid_attributes }
        }.to change(UserPlant, :count).by(1)
      end

      it "redirects to the created user_plant" do
        post user_plants_url, params: { user_plant: valid_attributes }
        expect(response).to redirect_to(user_plant_url(UserPlant.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new UserPlant" do
        expect {
          post user_plants_url, params: { user_plant: invalid_attributes }
        }.to change(UserPlant, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post user_plants_url, params: { user_plant: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested user_plant" do
        user_plant = UserPlant.create! valid_attributes
        patch user_plant_url(user_plant), params: { user_plant: new_attributes }
        user_plant.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the user_plant" do
        user_plant = UserPlant.create! valid_attributes
        patch user_plant_url(user_plant), params: { user_plant: new_attributes }
        user_plant.reload
        expect(response).to redirect_to(user_plant_url(user_plant))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        user_plant = UserPlant.create! valid_attributes
        patch user_plant_url(user_plant), params: { user_plant: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested user_plant" do
      user_plant = UserPlant.create! valid_attributes
      expect {
        delete user_plant_url(user_plant)
      }.to change(UserPlant, :count).by(-1)
    end

    it "redirects to the user_plants list" do
      user_plant = UserPlant.create! valid_attributes
      delete user_plant_url(user_plant)
      expect(response).to redirect_to(user_plants_url)
    end
  end
end