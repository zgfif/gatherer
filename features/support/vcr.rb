driver_hosts = Webdrivers::Common.subclasses.map { |driver| URI(driver.base_url).host }

VCR.configure do |c|
  c.cassette_library_dir = 'features/vcr'
  c.hook_into :webmock
  c.ignore_localhost = true
  c.ignore_hosts(*driver_hosts)
end

VCR.cucumber_tags do |t|
  t.tag '@vcr', use_scenario_name: true
  t.tags '@twitter', '@facebook'
end

# settings for cucumber
