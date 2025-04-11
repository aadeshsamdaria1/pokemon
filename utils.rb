
class Utils
  attr_reader :driver

  # Constructor to initialize the driver
  def initialize(driver)
    @driver = driver
  end

  def scroll_to_element(element, locator = nil)
    sleep(2)
    script_string = "var viewPortHeight = Math.max(document.documentElement.clientHeight, window.innerHeight || 0);" +
                    "var elementTop = arguments[0].getBoundingClientRect().top;" +
                    "window.scrollBy(0, elementTop-(viewPortHeight/2));"
    element = locator ? driver.find_element(locator) : element
    @driver.execute_script(script_string, element)
  end

  def fill_text_field(element, value)
    scroll_to_element(element)
    element.clear
    element.send_keys(value)
    element.click
    # @driver.find_element(:css, 'body').click
    # @driver.execute_script('document.body.click();')
  end

  def click_button(element)
    scroll_to_element(element)
    element.click
  end

  def select_dropdown(element, selection_type, value)
    scroll_to_element(element)
    Selenium::WebDriver::Support::Select.new(element).select_by(selection_type, value)
  end

  def execute_step(step_description)
    begin
      puts "Executing step: #{step_description}"
      sleep(1)
      yield
    rescue 
      raise e
    end
  end
  
end
