# == Schema Information
#
# Table name: purchases
#
#  id         :bigint           not null, primary key
#  date       :date
#  note       :string
#  price      :float
#  quantity   :integer
#  status     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Purchase, type: :model do
  describe "Validations" do
    before do
      usr = FactoryBot.create(:user)
      @purchase = Purchase.new (
        
      )
    end
  end

  describe "functions" do
  end
end
