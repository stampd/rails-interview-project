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

FactoryGirl.define do
  factory :question do
    title 'test'
    private false
    asker { FactoryGirl.create(:user) }

    trait :private do
      private true
    end
  end
end
