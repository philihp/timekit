# frozen_string_literal: true

describe Timekit::Credential::Client do
  before(:all) do
    @client = Timekit::Credential::Client.new
  end

  describe '#list' do
    before(:all) do
      stub_get('/credentials').to_return(
        status: 200,
        body: fixture('credential_list.json'),
        headers: { content_type: 'application/json' }
      )
    end

    it 'must list resources' do
      response = @client.list
      expect(response.code).to eq(200)
      data = JSON.parse(response)['data']
      expect(data.size).to eq(2)
      expect(a_get('/credentials')).to have_been_made
    end
  end

  describe '#create' do
    before(:all) do
      stub_post('/credentials').with(
        body: {
          type: 'client-token',
          scopes: 'widget',
          description: 'BookingJS token',
          referrer: 'http://localhost'
        }
      ).to_return(
        status: 200,
        body: fixture('credential_create.json'),
        headers: { content_type: 'application/json' }
      )
    end

    it 'must create the resource' do
      response = @client.create(
        'client-token',
        'widget',
        'BookingJS token',
        'http://localhost'
      )

      expect(response.code).to eq(200)
      expect(
        a_post('/credentials')
        .with(
          body: {
            type: 'client-token',
            scopes: 'widget',
            description: 'BookingJS token',
            referrer: 'http://localhost'
          }
        )
      ).to have_been_made
    end
  end

  describe '#delete' do
    before(:all) do
      stub_delete('/credentials/1').to_return(
        status: 204,
        body: '{}',
        headers: { content_type: 'application/json' }
      )
    end

    it 'must delete resource' do
      response = @client.delete(1)
      expect(response.code).to eq(204)
      expect(a_delete('/credentials/1')).to have_been_made
    end
  end
end
