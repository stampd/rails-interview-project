# encoding: utf-8
# frozen_string_literal: true
module Questions
  class Record < Grape::API
    resource :questions do
      before do
        access_denied!('Key does not exist') unless current_tenant
      end

      desc 'Get questions'
      get do
        records = Question.all_public
        present paginate(records), with: Question::Entity
      end
    end
  end
end
