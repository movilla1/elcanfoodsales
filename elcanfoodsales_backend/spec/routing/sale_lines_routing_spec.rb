require "rails_helper"

RSpec.describe SaleLinesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/sale_lines").to route_to("sale_lines#index")
    end

    it "routes to #show" do
      expect(:get => "/sale_lines/1").to route_to("sale_lines#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/sale_lines").to route_to("sale_lines#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/sale_lines/1").to route_to("sale_lines#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/sale_lines/1").to route_to("sale_lines#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/sale_lines/1").to route_to("sale_lines#destroy", :id => "1")
    end
  end
end
