# == Schema Information
#
# Table name: tenants
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  api_key      :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  access_count :integer          default(0)
#

require 'rails_helper'

RSpec.describe Tenant, type: :model do
  it { should validate_presence_of(:api_key) }
end
