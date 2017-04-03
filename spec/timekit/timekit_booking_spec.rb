# frozen_string_literal: true

describe Timekit::Booking::Client do
  before(:all) do
    @client = Timekit::Booking::Client.new
  end

  describe '#list' do
    before(:all) do
      stub_get('/bookings').to_return(
        status: 200,
        body: fixture('booking_list.json'),
        headers: { content_type: 'application/json' }
      )
    end

    it 'must list resources' do
      response = @client.list
      expect(response.code).to eq(200)
      data = JSON.parse(response)['data']
      expect(data.size).to eq(2)
      expect(a_get('/bookings')).to have_been_made
    end
  end

  describe '#show' do
    before(:all) do
      stub_get('/bookings/f68979ff-27da-4afd-8d0c-847f9340331b').to_return(
        status: 200,
        body: fixture('booking_show.json'),
        headers: { content_type: 'application/json' }
      )
    end

    it 'must show resource' do
      response = @client.show('f68979ff-27da-4afd-8d0c-847f9340331b')
      expect(response.code).to eq(200)
      expect(a_get('/bookings/f68979ff-27da-4afd-8d0c-847f9340331b'))
        .to have_been_made
    end
  end

  describe '#create' do
    before(:all) do
      @request_body = {
        graph: 'confirm_decline',
        action: 'create',
        event: {
          start: '2015-03-01T08:00:00+00:00',
          end: '2015-03-01T13:00:00+00:00',
          what: 'Mens haircut',
          where: 'Sesame St, Middleburg, FL 32068, USA',
          calendar_id: 'replace-with-id',
          description: 'Please arrive 10 minutes before you time begin'
        },
        customer: {
          name: 'Marty McFly',
          email: 'marty.mcfly@timekit.io',
          phone: '1-591-001-5403',
          voip: 'McFly',
          timezone: 'America/Los_Angeles'
        }
      }

      stub_post('/bookings').with(
        body: @request_body
      ).to_return(
        status: 200,
        body: fixture('booking_create.json'),
        headers: { content_type: 'application/json' }
      )
    end

    it 'must create the resource' do
      response = @client.create(
        'confirm_decline',
        {
          start: '2015-03-01T08:00:00+00:00',
          end: '2015-03-01T13:00:00+00:00',
          what: 'Mens haircut',
          where: 'Sesame St, Middleburg, FL 32068, USA',
          calendar_id: 'replace-with-id',
          description: 'Please arrive 10 minutes before you time begin'
        },
        {
          name: 'Marty McFly',
          email: 'marty.mcfly@timekit.io',
          phone: '1-591-001-5403',
          voip: 'McFly',
          timezone: 'America/Los_Angeles'
        },
        'create'
      )

      expect(response.code).to eq(200)
      expect(
        a_post('/bookings')
        .with(
          body: @request_body
        )
      ).to have_been_made
    end
  end

  describe '#update' do
    before(:all) do
      stub_put('/bookings/58190fc6-1ec0-4ebb-b627-7ce6aa9fc703/confirm').with(
        body: '{}'
      ).to_return(
        status: 200,
        body: fixture('booking_update.json'),
        headers: { content_type: 'application/json' }
      )
    end

    it 'must update the resource' do
      response = @client.update(
        '58190fc6-1ec0-4ebb-b627-7ce6aa9fc703',
        'confirm'
      )

      expect(response.code).to eq(200)
      expect(
        a_put('/bookings/58190fc6-1ec0-4ebb-b627-7ce6aa9fc703/confirm')
        .with(
          body: '{}'
        )
      ).to have_been_made
    end
  end
end
