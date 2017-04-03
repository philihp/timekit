# frozen_string_literal: true

describe Timekit::Event::Client do
  before(:all) do
    @client = Timekit::Event::Client.new
  end

  describe '#list' do
    before(:all) do
      stub_get('/events').with(
        body: {
          start: '2015-04-19T08:00:00+00:00',
          'end' => '2015-04-20T23:00:00+00:00'
        }
      ).to_return(
        status: 200,
        body: fixture('event_list.json'),
        headers: { content_type: 'application/json' }
      )
    end

    it 'must list resources' do
      response = @client.list(
        '2015-04-19T08:00:00+00:00',
        '2015-04-20T23:00:00+00:00'
      )
      expect(response.code).to eq(200)
      data = JSON.parse(response)['data']
      expect(data.size).to eq(4)
      expect(
        a_get('/events')
        .with(
          body: {
            start: '2015-04-19T08:00:00+00:00',
            end: '2015-04-20T23:00:00+00:00'
          }
        )
      ).to have_been_made
    end
  end

  describe '#show' do
    before(:all) do
      stub_get('/events/047568ef-4082-4089-a362-d6758f079cca').to_return(
        status: 200,
        body: fixture('event_show.json'),
        headers: { content_type: 'application/json' }
      )
    end

    it 'must show resource' do
      response = @client.show('047568ef-4082-4089-a362-d6758f079cca')
      expect(response.code).to eq(200)
      expect(a_get('/events/047568ef-4082-4089-a362-d6758f079cca'))
        .to have_been_made
    end
  end

  describe '#create' do
    before(:all) do
      stub_post('/events').with(
        body: {
          start: '2016-01-15T08:00:00+00:00',
          'end' => '2016-01-15T10:00:00+00:00',
          what: 'Voluptatem quod sint dolore non ut eos.',
          where: 'Nulla repellendus consequatur voluptatem officiis.',
          calendar_id: 'bfa0b9fa-36aa-4ae6-8096-f3b20fbed1d2',
          participants: %w[person1 person2],
          invite: false,
          description: 'Repellat alias possimus consectetur totam.',
          sync_provider: false,
          my_rsvp: 'needsAction',
          all_day: false
        }
      ).to_return(
        status: 201,
        body: '{}',
        headers: { content_type: 'application/json' }
      )
    end

    it 'must create the resource' do
      response = @client.create(
        '2016-01-15T08:00:00+00:00',
        '2016-01-15T10:00:00+00:00',
        'Voluptatem quod sint dolore non ut eos.',
        'Nulla repellendus consequatur voluptatem officiis.',
        'bfa0b9fa-36aa-4ae6-8096-f3b20fbed1d2',
        %w[person1 person2],
        false,
        'Repellat alias possimus consectetur totam.',
        false,
        'needsAction',
        false
      )

      expect(response.code).to eq(201)
      expect(
        a_post('/events')
        .with(
          body: {
            start: '2016-01-15T08:00:00+00:00',
            'end' => '2016-01-15T10:00:00+00:00',
            what: 'Voluptatem quod sint dolore non ut eos.',
            where: 'Nulla repellendus consequatur voluptatem officiis.',
            calendar_id: 'bfa0b9fa-36aa-4ae6-8096-f3b20fbed1d2',
            participants: %w[person1 person2],
            invite: false,
            description: 'Repellat alias possimus consectetur totam.',
            sync_provider: false,
            my_rsvp: 'needsAction',
            all_day: false
          }
        )
      ).to have_been_made
    end
  end

  describe '#update' do
    before(:all) do
      stub_put('/events/1').with(
        body: {
          start: '2016-01-15T08:00:00+00:00',
          'end' => '2016-01-15T10:00:00+00:00',
          what: 'Voluptatem quod sint dolore non ut eos.',
          where: 'Nulla repellendus consequatur voluptatem officiis.',
          participants: %w[person1 person2],
          all_day: false
        }
      ).to_return(
        status: 204,
        body: '{}',
        headers: { content_type: 'application/json' }
      )
    end

    it 'must update resource' do
      response = @client.update(
        1,
        '2016-01-15T08:00:00+00:00',
        '2016-01-15T10:00:00+00:00',
        'Voluptatem quod sint dolore non ut eos.',
        'Nulla repellendus consequatur voluptatem officiis.',
        %w[person1 person2],
        false
      )

      expect(response.code).to eq(204)
      expect(
        a_put('/events/1')
        .with(
          body: {
            start: '2016-01-15T08:00:00+00:00',
            'end' => '2016-01-15T10:00:00+00:00',
            what: 'Voluptatem quod sint dolore non ut eos.',
            where: 'Nulla repellendus consequatur voluptatem officiis.',
            participants: %w[person1 person2],
            all_day: false
          }
        )
      ).to have_been_made
    end
  end

  describe '#delete' do
    before(:all) do
      stub_delete('/events/1').to_return(
        status: 204,
        body: '{}',
        headers: { content_type: 'application/json' }
      )
    end

    it 'must delete resource' do
      response = @client.delete(1)
      expect(response.code).to eq(204)
      expect(a_delete('/events/1')).to have_been_made
    end
  end
end
