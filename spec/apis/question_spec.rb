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

RSpec.describe Question, type: :request do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:private_question) { FactoryGirl.create(:question, :private, asker: user) }
  let!(:public_question) { FactoryGirl.create(:question, asker: user) }
  let!(:private_answer) { FactoryGirl.create(:answer, question: private_question, answerer: user) }
  let!(:public_answer) { FactoryGirl.create(:answer, question: public_question, answerer: user) }
  let!(:tenant) { FactoryGirl.create(:tenant) }


  describe 'get /questions' do
    context 'valid tenant' do
      it 'should return public questions' do
        get '/api/v1/questions', nil, {'Authorization' => tenant.api_key}

        expect(response.status).to eq(200)

        body = JSON.parse(response.body)
        questions = body.find_all { |data| data[:private] == true }
        expect(questions).to be_empty
      end

      it 'should increment Tenant access count' do
        expect(tenant.access_count).to eq(0)

        get '/api/v1/questions', nil, {'Authorization' => tenant.api_key}

        expect(response.status).to eq(200)
        tenant.reload
        expect(tenant.access_count).to eq(1)
      end
    end

    context 'invalid tenant' do
      it 'should return an error' do
        get '/api/v1/questions', nil, {'Authorization' => 'some invalid key'}

        expect(response.status).to eq(401)
        expect(response.message).to eq('Unauthorized')
      end
    end
  end
end
