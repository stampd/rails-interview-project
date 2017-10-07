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

FactoryGirl.define do
  factory :answer do
    body 'test'
    question { FactoryGirl.create(:question) }
    answerer { FactoryGirl.create(:user) }
  end
end
