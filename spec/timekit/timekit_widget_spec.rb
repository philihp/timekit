# frozen_string_literal: true

describe Timekit::Widget::Client do
  before(:all) do
    @client = Timekit::Widget::Client.new
  end

  describe '#list' do
    before(:all) do
      stub_get('/widgets').to_return(
        status: 200,
        body: fixture('widget_list.json'),
        headers: { content_type: 'application/json' }
      )
    end

    it 'must list resources' do
      response = @client.list

      expect(response.code).to eq(200)
      data = JSON.parse(response)['data']
      expect(data.size).to eq(2)
      expect(a_get('/widgets')).to have_been_made
    end
  end

  describe '#embed' do
    before(:all) do
      stub_get('/widgets/embed/826ddc8e-8698-45be-9320-0c81dcf797d9').to_return(
        status: 200,
        body: fixture('widget_embed.json'),
        headers: { content_type: 'application/json' }
      )
    end

    it 'must show resource' do
      response = @client.embed('826ddc8e-8698-45be-9320-0c81dcf797d9')
      expect(response.code).to eq(200)
      expect(a_get('/widgets/embed/826ddc8e-8698-45be-9320-0c81dcf797d9'))
        .to have_been_made
    end
  end

  describe '#hosted' do
    before(:all) do
      stub_get('/widgets/hosted/826ddc8e-8698-45be-9320-0c81dcf797d9')
        .to_return(
          status: 200,
          body: fixture('widget_hosted.json'),
          headers: { content_type: 'application/json' }
        )
    end

    it 'must show resource' do
      response = @client.hosted('826ddc8e-8698-45be-9320-0c81dcf797d9')
      expect(response.code).to eq(200)
      expect(a_get('/widgets/hosted/826ddc8e-8698-45be-9320-0c81dcf797d9'))
        .to have_been_made
    end
  end

  describe '#create' do
    before(:all) do
      stub_post('/widgets').with(
        body: {
          name: 'My Test Widget',
          slug: 'my-test-widget',
          config: {
            email: 'marty.mcfly@timekit.io',
            calendar: '3653d9a9-46d3-4270-8d34-34b3d871128d',
            apiToken: 'xwcgiK7u7EZSpIkCSt3Oaq1eFy1fZBJA'
          }
        }
      ).to_return(
        status: 200,
        body: fixture('widget_create.json'),
        headers: { content_type: 'application/json' }
      )
    end

    it 'must create the resource' do
      response = @client.create(
        {
          email: 'marty.mcfly@timekit.io',
          calendar: '3653d9a9-46d3-4270-8d34-34b3d871128d',
          apiToken: 'xwcgiK7u7EZSpIkCSt3Oaq1eFy1fZBJA'
        },
        'My Test Widget',
        'my-test-widget'
      )

      expect(response.code).to eq(200)
      expect(
        a_post('/widgets')
        .with(
          body: {
            name: 'My Test Widget',
            slug: 'my-test-widget',
            config: {
              email: 'marty.mcfly@timekit.io',
              calendar: '3653d9a9-46d3-4270-8d34-34b3d871128d',
              apiToken: 'xwcgiK7u7EZSpIkCSt3Oaq1eFy1fZBJA'
            }
          }
        )
      ).to have_been_made
    end
  end

  describe '#update' do
    before(:all) do
      stub_put('/widgets/1').with(
        body: {
          name: 'My Test Widget',
          slug: 'my-test-widget',
          config: {
            email: 'marty.mcfly@timekit.io',
            calendar: '3653d9a9-46d3-4270-8d34-34b3d871128d',
            apiToken: 'xwcgiK7u7EZSpIkCSt3Oaq1eFy1fZBJA'
          }
        }
      ).to_return(
        status: 204,
        body: '',
        headers: { content_type: 'application/json' }
      )
    end

    it 'must update the resource' do
      response = @client.update(
        '1',
        {
          email: 'marty.mcfly@timekit.io',
          calendar: '3653d9a9-46d3-4270-8d34-34b3d871128d',
          apiToken: 'xwcgiK7u7EZSpIkCSt3Oaq1eFy1fZBJA'
        },
        'My Test Widget',
        'my-test-widget'
      )

      expect(response.code).to eq(204)
      expect(
        a_put('/widgets/1')
        .with(
          body: {
            name: 'My Test Widget',
            slug: 'my-test-widget',
            config: {
              email: 'marty.mcfly@timekit.io',
              calendar: '3653d9a9-46d3-4270-8d34-34b3d871128d',
              apiToken: 'xwcgiK7u7EZSpIkCSt3Oaq1eFy1fZBJA'
            }
          }
        )
      ).to have_been_made
    end
  end

  describe '#delete' do
    before(:all) do
      stub_delete('/widgets/1').to_return(
        status: 204,
        body: '{}',
        headers: { content_type: 'application/json' }
      )
    end

    it 'must delete resource' do
      response = @client.delete(1)
      expect(response.code).to eq(204)
      expect(a_delete('/widgets/1')).to have_been_made
    end
  end
end
