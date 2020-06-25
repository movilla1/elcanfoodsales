require "rails_helper"

RSpec.describe Api::V1::SuppliersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/suppliers").to route_to("suppliers#index")
    end

    it "routes to #show" do
      expect(:get => "/suppliers/1").to route_to("suppliers#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/suppliers").to route_to("suppliers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/suppliers/1").to route_to("suppliers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/suppliers/1").to route_to("suppliers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/suppliers/1").to route_to("suppliers#destroy", :id => "1")
    end
  end
end
