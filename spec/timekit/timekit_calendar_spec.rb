# frozen_string_literal: true

describe Timekit::Calendar::Client do
  before(:all) do
    @client = Timekit::Calendar::Client.new
  end

  describe '#list' do
    before(:all) do
      stub_get('/calendars').to_return(
        status: 200,
        body: fixture('calendar_list.json'),
        headers: { content_type: 'application/json' }
      )
    end

    it 'must list resources' do
      response = @client.list
      expect(response.code).to eq(200)
      data = JSON.parse(response)['data']
      expect(data.size).to eq(2)
      expect(a_get('/calendars')).to have_been_made
    end
  end

  describe '#show' do
    before(:all) do
      stub_get('/calendars/bfa0b9fa-36aa-4ae6-8096-f3b20fbed1d2').to_return(
        status: 200,
        body: fixture('calendar_show.json'),
        headers: { content_type: 'application/json' }
      )
    end

    it 'must show resource' do
      response = @client.show('bfa0b9fa-36aa-4ae6-8096-f3b20fbed1d2')
      expect(response.code).to eq(200)
      expect(a_get('/calendars/bfa0b9fa-36aa-4ae6-8096-f3b20fbed1d2'))
        .to have_been_made
    end
  end

  describe '#create' do
    before(:all) do
      stub_post('/calendars').with(
        body: {
          name: 'My Calendar',
          description: 'This is my personal calendar',
          foregroundcolor: '#000000',
          backgroundcolor: '#FFFFFF'
        }
      ).to_return(
        status: 201,
        body: fixture('calendar_create.json'),
        headers: { content_type: 'application/json' }
      )
    end

    it 'must create the resource' do
      response = @client.create(
        'My Calendar',
        'This is my personal calendar',
        '#FFFFFF',
        '#000000'
      )

      expect(response.code).to eq(201)
      expect(
        a_post('/calendars')
        .with(
          body: {
            name: 'My Calendar',
            description: 'This is my personal calendar',
            backgroundcolor: '#FFFFFF',
            foregroundcolor: '#000000'
          }
        )
      ).to have_been_made
    end
  end

  describe '#delete' do
    before(:all) do
      stub_delete('/calendars/1').to_return(
        status: 204,
        body: '{}',
        headers: { content_type: 'application/json' }
      )
    end

    it 'must delete resource' do
      response = @client.delete(1)
      expect(response.code).to eq(204)
      expect(a_delete('/calendars/1')).to have_been_made
    end
  end
end
