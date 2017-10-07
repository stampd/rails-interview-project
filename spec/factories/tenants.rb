# == Schema Information
#
# Table name: tenants
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  api_key    :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :tenant do
    name 'tenant'
    api_key 'key'
  end
end
