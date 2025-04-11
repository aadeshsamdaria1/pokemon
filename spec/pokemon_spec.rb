
require 'spec_helper'
require_relative '../utils'
require_relative '../pages/pokemonapiPage'
require 'net/http'

RSpec.describe 'Pokemon Functionality', type: :feature do
  before(:all) do
    @utils = Utils.new(@driver)  
    @pokemon_page = PokemonPage.new(@driver)
  end

  # THESE ARE SAMPLES TO DISPLAY AUTOMATIONS OF POKEMON.CO

  it 'Search pokemon using pokemon name - via UI', :pokemon_1 do
    @utils.execute_step("Search for pokemon.co website") do
      @driver.navigate.to('https://pokeapi.co/')
      sample_pokemon = 'pokemon/pikachu'
      @utils.fill_text_field(@pokemon_page.url_input, sample_pokemon)
      @utils.click_button(@pokemon_page.submit)
      sleep(2)
      expect(@driver.page_source).to include("Resource for pikachu")
      # can write more expected here or create a method to validate the response
      # Problematic because the page is ad prone
    end
  end

  it 'fetches details for a valid Pokémon name - via API', :pokemon_2 do
    @utils.execute_step("Fetch Pokémon details") do
      @data = @pokemon_page.fetch_pokemon('pikachu')
    end

    @utils.execute_step("Verify Pokémon details") do
      expect(@data['name']).to eq('pikachu')
      expect(@data['id']).to eq(25)
      expect(@data['types']).not_to be_empty
      expect(@data['types'].map { |t| t['type']['name'] }).to include('electric')
      # can write more expected here or create a method to validate the response
    end
  end

  it 'fetches details for a valid Pokémon id - via API', :pokemon_3 do
    @utils.execute_step("Fetch Pokémon details") do
      @data = @pokemon_page.fetch_pokemon('25')
    end

    @utils.execute_step("Verify Pokémon details") do
      expect(@data['name']).to eq('pikachu')
      expect(@data['id']).to eq(25)
      expect(@data['types']).not_to be_empty
      expect(@data['types'].map { |t| t['type']['name'] }).to include('electric')
      # can write more expected here or create a method to validate the response
    end
  end

  it 'fetches details for a invalid Pokémon name - via API', :pokemon_4 do
    @utils.execute_step("Fetch Pokémon details") do
      expect {
        @pokemon_page.fetch_pokemon('Kingkong')
      }.to raise_error(RuntimeError, /HTTP Error/)
    end
  end

end