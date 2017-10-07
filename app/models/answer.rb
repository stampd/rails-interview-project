# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  body        :string           not null
#  question_id :integer          not null
#  user_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Answer < ActiveRecord::Base
  include Grape::Entity::DSL
  entity :id, :body, :question_id,
         :created_at, :updated_at do
    expose :answerer, using: User::Entity
  end

  belongs_to :question
  belongs_to :answerer, class_name: 'User', foreign_key: :user_id, inverse_of: :answers

end
