# frozen_string_literal: true

describe Timekit do
  describe '.configure' do
    before(:all) do
      @app = Faker::Lorem.word
      @email = Faker::Internet.email
      @api_token = Faker::Internet.password(16)

      Timekit.configure(
        app: @app,
        email: @email,
        api_token: @api_token
      )
    end

    it 'must be configured' do
      expect(Timekit.config[:app]).to eq(@app)
      expect(Timekit.config[:credentials].email).to eq(@email)
      expect(Timekit.config[:credentials].api_token).to eq(@api_token)
    end
  end

  describe '.calendar_client' do
    subject { Timekit.calendar_client }

    it 'should return client' do
      expect(subject).to be_a Timekit::Calendar::Client
    end
  end

  describe '.app_client' do
    subject { Timekit.app_client }

    it 'should return client' do
      expect(subject).to be_a Timekit::App::Client
    end
  end

  describe '.credential_client' do
    subject { Timekit.credential_client }

    it 'should return client' do
      expect(subject).to be_a Timekit::Credential::Client
    end
  end

  describe '.event_client' do
    subject { Timekit.event_client }

    it 'should return client' do
      expect(subject).to be_a Timekit::Event::Client
    end
  end

  describe '.user_client' do
    subject { Timekit.user_client }

    it 'should return client' do
      expect(subject).to be_a Timekit::User::Client
    end
  end

  describe '.findtime_client' do
    subject { Timekit.findtime_client }

    it 'should return client' do
      expect(subject).to be_a Timekit::Findtime::Client
    end
  end

  describe '.widget_client' do
    subject { Timekit.widget_client }

    it 'should return client' do
      expect(subject).to be_a Timekit::Widget::Client
    end
  end

  describe '.booking_client' do
    subject { Timekit.booking_client }

    it 'should return client' do
      expect(subject).to be_a Timekit::Booking::Client
    end
  end
end
