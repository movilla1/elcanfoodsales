require "rails_helper"

RSpec.describe Api::V1::StockHistoriesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/api/v1/stock_histories").to route_to("api/v1/stock_histories#index", format: :json)
    end

    it "routes to #show" do
      expect(:get => "/api/v1/stock_histories/1").to route_to("api/v1/stock_histories#show", :id => "1", format: :json)
    end


    it "routes to #create" do
      expect(:post => "/api/v1/stock_histories").to route_to("api/v1/stock_histories#create", format: :json)
    end

    it "routes to #update via PUT" do
      expect(:put => "/api/v1/stock_histories/1").to route_to("api/v1/stock_histories#update", :id => "1", format: :json)
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/api/v1/stock_histories/1").to route_to("api/v1/stock_histories#update", :id => "1", format: :json)
    end

    it "routes to #destroy" do
      expect(:delete => "/api/v1/stock_histories/1").to route_to("api/v1/stock_histories#destroy", :id => "1", format: :json)
    end
  end
end
