require "rails_helper"

RSpec.describe Api::V1::PriceLists::PricesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/api/v1/price_lists/1/prices").to route_to("api/v1/prices#index", format: :json)
    end

    it "routes to #show" do
      expect(:get => "/api/v1/price_lists/1/prices/1").to route_to("api/v1/prices#show", :id => "1", format: :json)
    end


    it "routes to #create" do
      expect(:post => "/api/v1/price_lists/1/prices").to route_to("api/v1/prices#create", format: :json)
    end

    it "routes to #update via PUT" do
      expect(:put => "/api/v1/price_lists/1/prices/1").to route_to("api/v1/prices#update", :id => "1", format: :json)
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/api/v1/price_lists/1/prices/1").to route_to("api/v1/prices#update", :id => "1", format: :json)
    end

    it "routes to #destroy" do
      expect(:delete => "/api/v1/price_lists/1/prices/1").to route_to("api/v1/prices#destroy", :id => "1", format: :json)
    end
  end
end
