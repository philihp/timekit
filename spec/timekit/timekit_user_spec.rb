# frozen_string_literal: true

describe Timekit::User::Client do
  before(:all) do
    @client = Timekit::User::Client.new
  end

  describe '.auth' do
    before(:all) do
      stub_post('/auth').with(
        body: {
          email: 'doc.brown@timekit.io',
          password: 'Password123'
        }
      ).to_return(
        status: 200,
        body: fixture('auth.json'),
        headers: { content_type: 'application/json' }
      )
    end

    it 'must auth' do
      response = Timekit::User.auth(
        'doc.brown@timekit.io',
        'Password123'
      )

      expect(response.code).to eq(200)
      expect(
        a_post('/auth')
        .with(
          body: {
            email: 'doc.brown@timekit.io',
            password: 'Password123'
          }
        )
      ).to have_been_made
    end
  end

  describe '#me' do
    before(:all) do
      stub_get('/users/me').to_return(
        status: 200,
        body: fixture('user_me.json'),
        headers: { content_type: 'application/json' }
      )
    end

    it 'must show me' do
      response = @client.me

      expect(response.code).to eq(200)
      expect(a_get('/users/me')).to have_been_made
    end
  end

  describe '#timezone' do
    before(:all) do
      stub_get('/users/timezone/email@example.com').to_return(
        status: 200,
        body: fixture('user_timezone.json'),
        headers: { content_type: 'application/json' }
      )
    end

    it 'must show timezone' do
      response = @client.timezone('email@example.com')

      expect(response.code).to eq(200)
      data = JSON.parse(response)['data']
      expect(data['timezone']).to eq('Europe/Stockholm')
      expect(a_get('/users/timezone/email@example.com')).to have_been_made
    end
  end

  describe '.create' do
    before(:all) do
      stub_post('/users').with(
        body: {
          email: 'ph@timekit.io',
          timezone: 'Europe/Copenhagen',
          first_name: 'Peter',
          last_name: 'Hansen',
          password: 'Password123'
        }
      ).to_return(
        status: 200,
        body: fixture('user_create.json'),
        headers: { content_type: 'application/json' }
      )
    end

    it 'must create the resource' do
      response = Timekit::User.create(
        'ph@timekit.io',
        'Europe/Copenhagen',
        'Peter',
        'Hansen',
        'Password123'
      )

      expect(response.code).to eq(200)
      expect(
        a_post('/users')
        .with(
          body: {
            email: 'ph@timekit.io',
            timezone: 'Europe/Copenhagen',
            first_name: 'Peter',
            last_name: 'Hansen',
            password: 'Password123'
          }
        )
      ).to have_been_made
    end
  end

  describe '#update' do
    before(:all) do
      stub_put('/users/me').with(
        body: {
          first_name: 'Marty',
          last_name: 'McFly',
          timezone: 'America/Los_angeles',
          password: 'my-new-password'
        }
      ).to_return(
        status: 200,
        body: fixture('user_update.json'),
        headers: { content_type: 'application/json' }
      )
    end

    it 'must update resource' do
      response = @client.update(
        'Marty',
        'McFly',
        'America/Los_angeles',
        'my-new-password'
      )

      expect(response.code).to eq(200)
      expect(
        a_put('/users/me')
        .with(
          body: {
            first_name: 'Marty',
            last_name: 'McFly',
            timezone: 'America/Los_angeles',
            password: 'my-new-password'
          }
        )
      ).to have_been_made
    end
  end

  describe '#resetpassword' do
    before(:all) do
      stub_post('/users/resetpassword').with(
        body: {
          email: 'ph@timekit.io'
        }
      ).to_return(
        status: 200,
        body: '{}',
        headers: { content_type: 'application/json' }
      )
    end

    it 'must reset password' do
      response = @client.reset_password('ph@timekit.io')

      expect(response.code).to eq(200)
      expect(
        a_post('/users/resetpassword')
        .with(
          body: {
            email: 'ph@timekit.io'
          }
        )
      ).to have_been_made
    end
  end
end
