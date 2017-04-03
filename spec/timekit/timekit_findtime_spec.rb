# frozen_string_literal: true

describe Timekit::Findtime::Client do
  before(:all) do
    @client = Timekit::Findtime::Client.new
  end

  describe '#findtime' do
    before(:all) do
      stub_post('/findtime').with(
        body: {
          emails: [
            'doc.brown@timekit.io',
            'marty.mcfly@timekit.io'
          ],
          filters: {
            or: [
              { specific_day: { day: 'Monday' } },
              {
                specific_day_and_time: {
                  day: 'Wednesday',
                  start: 10,
                  end: 12,
                  timezone: 'Europe/Copenhagen'
                }
              }
            ],
            and: [
              { business_hours: { timezone: 'America/Los_angeles' } }
            ]
          },
          future: '2 days',
          length: '30 minutes',
          sort: 'asc',
          ignore_all_day_events: false,
          all_solutions: false
        }
      ).to_return(
        status: 200,
        body: fixture('findtime_list.json'),
        headers: { content_type: 'application/json' }
      )
    end

    it 'must list times' do
      response = @client.query(
        [
          'doc.brown@timekit.io',
          'marty.mcfly@timekit.io'
        ],
        nil,
        nil,
        {
          or: [
            { specific_day: { day: 'Monday' } },
            {
              specific_day_and_time: {
                day: 'Wednesday',
                start: 10,
                end: 12,
                timezone: 'Europe/Copenhagen'
              }
            }
          ],
          and: [
            { business_hours: { timezone: 'America/Los_angeles' } }
          ]
        },
        nil,
        nil,
        '2 days',
        '30 minutes'
      )

      expect(response.code).to eq(200)
      expect(
        a_post('/findtime')
        .with(
          body: {
            emails: [
              'doc.brown@timekit.io',
              'marty.mcfly@timekit.io'
            ],
            filters: {
              or: [
                { specific_day: { day: 'Monday' } },
                {
                  specific_day_and_time: {
                    day: 'Wednesday',
                    start: 10,
                    end: 12,
                    timezone: 'Europe/Copenhagen'
                  }
                }
              ],
              and: [
                { business_hours: { timezone: 'America/Los_angeles' } }
              ]
            },
            future: '2 days',
            length: '30 minutes',
            sort: 'asc',
            ignore_all_day_events: false,
            all_solutions: false
          }
        )
      ).to have_been_made
    end
  end
end
