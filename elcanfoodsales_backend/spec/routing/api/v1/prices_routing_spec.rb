require "rails_helper"

RSpec.describe Api::V1::PricesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/api/v1/price_lists/1/prices").to route_to(
        controller: "api/v1/prices",
        action: "index",
        price_list_id: "1",
        format: :json
      )
    end

    it "routes to #show" do
      expect(get: "/api/v1/price_lists/1/prices/1").to route_to(
        controller: "api/v1/prices",
        action: "show",
        price_list_id: "1",
        format: :json,
        id: "1"
      )
    end


    it "routes to #create" do
      expect(post: "/api/v1/price_lists/1/prices").to route_to("api/v1/prices#create", price_list_id: "1", format: :json)
    end

    it "routes to #update via PUT" do
      expect(put: "/api/v1/price_lists/1/prices/1").to route_to("api/v1/prices#update", price_list_id: "1", :id => "1", format: :json)
    end

    it "routes to #update via PATCH" do
      expect(patch: "/api/v1/price_lists/1/prices/1").to route_to("api/v1/prices#update", price_list_id: "1", :id => "1", format: :json)
    end

    it "routes to #destroy" do
      expect(delete: "/api/v1/price_lists/1/prices/1").to route_to("api/v1/prices#destroy", price_list_id: "1", :id => "1", format: :json)
    end
  end
end
