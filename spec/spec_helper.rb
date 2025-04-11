require 'selenium-webdriver'
require_relative '../utils'
require 'rspec/retry'
require 'pry'
require 'json'
require 'rspec_html_formatter'

RSpec.configure do |config|
  config.full_backtrace = true
  config.formatter = :documentation 
  config.verbose_retry = true
  config.display_try_failure_messages = true

  config.around(:each) do |example|
    example.run_with_retry retry: 1 # Retries once after the initial failure
  end
  config.before(:all) do
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_preference(:browser, set_download_behavior: { behavior: 'allow' })
    options.add_preference(:safebrowsing, enabled: true)
    if ENV['IS_LOCAL'].to_s.downcase != "true"
      puts "Running on CI"
      options.binary = '/usr/bin/chromium' 
      options.add_argument('--no-sandbox') 
      options.add_argument('--disable-dev-shm-usage') 
    end
    options.add_argument('--headless')
    options.add_argument('--disable-gpu')
    puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Launching Chrome @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" 
    @driver = Selenium::WebDriver.for :chrome, options: options
    @driver.manage.window.maximize
    @utils = Utils.new(@driver)
  end

  config.after(:all) do
    @driver.quit
  end

end
