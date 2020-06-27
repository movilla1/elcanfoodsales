# == Schema Information
#
# Table name: suppliers
#
#  id           :bigint           not null, primary key
#  contact_name :string
#  date_start   :date
#  email        :string
#  name         :string
#  phone        :string
#  status       :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'rails_helper'

RSpec.describe Supplier, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
