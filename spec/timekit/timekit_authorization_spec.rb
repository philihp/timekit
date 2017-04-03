# frozen_string_literal: true

describe Timekit::Authorization do
  describe '#as_json' do
    subject do
      Timekit::Authorization.new(
        Faker::Internet.email, Faker::Internet.password(16)
      )
    end

    it 'must return json' do
      json = subject.as_json
      expect(json[:email]).to eq(subject.email)
      expect(json[:api_token]).to eq(subject.api_token)
    end
  end
end
