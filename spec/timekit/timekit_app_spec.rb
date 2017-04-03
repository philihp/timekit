# frozen_string_literal: true

describe Timekit::App::Client do
  before(:all) do
    @client = Timekit::App::Client.new
  end

  describe '#list' do
    before(:all) do
      stub_get('/apps').to_return(
        status: 200,
        body: fixture('app_list.json'),
        headers: { content_type: 'application/json' }
      )
    end

    it 'must list the resources' do
      response = @client.list

      expect(response.code).to eq(200)
      data = JSON.parse(response)['data']
      expect(data.size).to eq(2)
      expect(a_get('/apps')).to have_been_made
    end
  end

  describe '#create' do
    before(:all) do
      stub_post('/apps').to_return(
        status: 201,
        body: fixture('app_create.json'),
        headers: { content_type: 'application/json' }
      )
    end

    it 'must create the resource' do
      response = @client.create(
        'Test 121',
        callback: 'http://myapp.io/#/googlecallback'
      )

      expect(response.code).to eq(201)
      expect(
        a_post('/apps')
        .with(
          body: {
            name: 'Test 121',
            settings: {
              callback: 'http://myapp.io/#/googlecallback'
            }
          }
        )
      ).to have_been_made
    end
  end

  describe '#update' do
    before(:all) do
      stub_put('/apps/my-app-name').to_return(
        status: 204,
        body: '{}',
        headers: { content_type: 'application/json' }
      )
    end

    it 'must update the resource' do
      response = @client.update(
        'my-app-name',
        name: 'My App Name',
        callback: 'http://myapp.io/#/googlecallback'
      )

      expect(response.code).to eq(204)
      expect(
        a_put('/apps/my-app-name')
        .with(
          body: {
            name: 'My App Name',
            callback: 'http://myapp.io/#/googlecallback'
          }
        )
      ).to have_been_made
    end
  end

  describe '#delete' do
    before(:all) do
      stub_delete('/apps/my-app-name').to_return(
        status: 204,
        body: '{}',
        headers: { content_type: 'application/json' }
      )
    end

    it 'must update the resource' do
      response = @client.delete('my-app-name')

      expect(response.code).to eq(204)
      expect(a_delete('/apps/my-app-name')).to have_been_made
    end
  end
end
