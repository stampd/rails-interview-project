# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  private    :boolean          default(FALSE)
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Question < ActiveRecord::Base
  include Grape::Entity::DSL
  entity :id, :title, :private, :answers,
         :created_at, :updated_at do
    expose :asker, using: User::Entity
  end

  has_many :answers
  belongs_to :asker, class_name: 'User', foreign_key: :user_id, inverse_of: :questions

  scope :all_public, -> { where(private: false) }

end
