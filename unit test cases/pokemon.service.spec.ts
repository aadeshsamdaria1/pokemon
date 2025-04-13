// This code needs to be run in an Angular environment with the necessary dependencies installed.

import 'zone.js'
import { TestBed } from '@angular/core/testing';
import { HttpClientTestingModule } from '@angular/common/http/testing'; // Import the HttpClientTestingModule
import { PokemonService } from './pokemon.service';
import { Pokemon } from '~features/pokemon/types/pokemon.type';

describe('PokemonService', () => {
  let service: PokemonService;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule], // Add HttpClientTestingModule here
      providers: [PokemonService],
    });

    service = TestBed.inject(PokemonService);
  });

  it('should fetch a single pokemon and return it correctly', () => {
    const mockPokemon: Pokemon = {
      id: 1,
      order: '1',
      name: 'bulbasaur',
      height: '7',
      weight: '69',
      sprites: {
        front_default: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
        front_shiny: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png',
      },
    };

    const pokemonIdOrName = 1; // The Pokémon ID or name to fetch

    // Call the getPokemon method with the ID or name
    service.getPokemon(pokemonIdOrName).subscribe((pokemon) => {
      expect(pokemon).toEqual(mockPokemon); // Expect the returned Pokémon to match the mock
    });
    
  });

  it('should trim input if given a string with spaces', () => {
    service.getPokemon(' 1 ').subscribe((pokemon) => {
      expect(pokemon.id).toBe(1);
    });
  });
    
  it('should fetch a list of pokemons and return it correctly', () => {
    const mockPokemons: Pokemon[] = [
      {
        id: 1,
        order: '1',
        name: 'bulbasaur',
        height: '7',
        weight: '69',
        sprites: {
          front_default: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
          front_shiny: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/1.png',
        },
      },
      {
        id: 2,
        order: '2',
        name: 'ivysaur',
        height: '10',
        weight: '130',
        sprites: {
          front_default: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png',
          front_shiny: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/2.png',
        },
      },
    ];
  
    const pokemonIds = [1, 2]; // Array of Pokémon IDs to pass to the method
  
    // Call the getPokemons method with the IDs
    service.getPokemons(pokemonIds).subscribe((pokemons) => {
      expect(pokemons).toEqual(mockPokemons); // Expect the returned Pokémon list to match the mock
    });
  });
     
});