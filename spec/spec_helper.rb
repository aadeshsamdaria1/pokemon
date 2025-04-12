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
    options.add_argument('--headless')
    options.add_argument('--disable-gpu')
    puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Launching Chrome @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" 
    @driver = Selenium::WebDriver.for :chrome, options: options
    @driver.manage.window.maximize
  end

  config.after(:all) do
    @driver.quit
  end

end
