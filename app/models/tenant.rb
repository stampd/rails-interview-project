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

class Tenant < ActiveRecord::Base
  include Grape::Entity::DSL
  entity :id, :name, :access_count,
         :created_at, :updated_at

  before_create :generate_api_key
  validates_presence_of :api_key
  
  private

  def generate_api_key
    self.api_key = SecureRandom.hex(16)
  end

end
