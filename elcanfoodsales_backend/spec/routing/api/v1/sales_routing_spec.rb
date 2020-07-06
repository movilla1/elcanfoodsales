require "rails_helper"

RSpec.describe Api::V1::SalesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/api/v1/sales").to route_to("api/v1/sales#index", format: :json)
    end

    it "routes to #show" do
      expect(:get => "/api/v1/sales/1").to route_to("api/v1/sales#show", :id => "1", format: :json)
    end


    it "routes to #create" do
      expect(:post => "/api/v1/sales").to route_to("api/v1/sales#create", format: :json)
    end

    it "routes to #update via PUT" do
      expect(:put => "/api/v1/sales/1").to route_to("api/v1/sales#update", :id => "1", format: :json)
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/api/v1/sales/1").to route_to("api/v1/sales#update", :id => "1", format: :json)
    end

    it "routes to #destroy" do
      expect(:delete => "/api/v1/sales/1").to route_to("api/v1/sales#destroy", :id => "1", format: :json)
    end
  end
end
