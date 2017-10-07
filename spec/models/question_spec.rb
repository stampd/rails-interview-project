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

require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should belong_to(:asker) }
  it { should have_many(:answers) }
end
