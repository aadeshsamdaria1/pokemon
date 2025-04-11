require_relative '../utils'

class PokemonPage
  LOCATORS = {
    url_input: { id: 'url-input' },
    submit: { xpath: '//button[text()="Submit"]'},
    # Add more locators as needed
    
  }.freeze

  def initialize(driver)
    @driver = driver
    @utils = Utils.new(driver) 
  end

  # Define the page elements
  LOCATORS.each do |name, locator|
    define_method(name) do |*args|
      locator = locator.is_a?(Proc) ? locator.call(*args) : locator
      @driver.find_element(locator)
    end
  end

  # ----------- Method Definition ----------

  # Fetch Pokémon details from the API
  def fetch_pokemon(name_or_id)
    url = URI("https://pokeapi.co/api/v2/pokemon/#{name_or_id}")
    response = Net::HTTP.get_response(url)
    raise "HTTP Error: #{response.code}" unless response.is_a?(Net::HTTPSuccess)
    JSON.parse(response.body)
  end
end