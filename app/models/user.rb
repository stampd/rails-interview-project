# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  include Grape::Entity::DSL
  entity :id, :name,
         :created_at, :updated_at

  has_many :questions, inverse_of: :asker
  has_many :answers,   inverse_of: :answerer

end
