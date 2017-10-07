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

require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to(:question) }
  it { should belong_to(:answerer) }
end
