module Helpers
  def docusign_mock(request)
    WebMock.reset!
    endpoint = standard_endpoints(request)
    data_file = File.new(filename_to_path_json(endpoint))
    WebMock
      .stub_request(:get, endpoint_to_url(endpoint))
      .to_return(body: data_file, status: 200, headers: { 'Content-Type' => 'application/json' })
  end

  def docusign_mock_batch(request)
    endpoint = standard_endpoints(request)
    batch1_file = File.new(filename_to_path_json([endpoint, '_page1']))
    batch2_file = File.new(filename_to_path_json([endpoint, '_page2']))
    url = endpoint_to_url(endpoint)
    WebMock.reset!
    WebMock
      .stub_request(:get, [url, '?count=100'].join)
      .to_return(body: batch1_file, status: 200, headers: { 'Content-Type' => 'application/json' })
    WebMock
      .stub_request(:get, [url, '?count=100&startPosition=10'].join)
      .to_return(body: batch2_file, status: 200, headers: { 'Content-Type' => 'application/json' })
  end

  private

  def filename_to_path_json(filenames)
    filename_to_path([filenames, '.json'].flatten.join)
  end

  def filename_to_path(filename)
    docusign_stub_path = ROOT.join('spec', 'stub_responses')
    File.new(docusign_stub_path.join(filename))
  end

  def endpoint_to_url(endpoint)
    dotloop_url = 'https://stage.cartavi.com/restapi/v1/'
    [dotloop_url, endpoint].join
  end

  def standard_endpoints(lookup)
    {
      rooms:           'rooms',
      room:            'rooms/123'
    }[lookup.to_sym]
  end
end
