import 'zone.js';
import { TestBed } from '@angular/core/testing';
import { PokemonSearchInputComponent } from './pokemon-search-input.component'; // your component
import { Router } from '@angular/router';
import { of } from 'rxjs';
import { PokemonService } from '~features/pokemon/services/pokemon.service';
import { AlertService } from '~core/services/ui/alert.service';

// Create your mocks
const mockRouter = jasmine.createSpyObj('Router', ['navigate']);
const mockPokemonService = jasmine.createSpyObj('PokemonService', ['getPokemon']);
const mockAlertService = jasmine.createSpyObj('AlertService', ['createErrorAlert']);

describe('PokemonSearchInputComponent', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      // ✅ Use `imports` instead of `declarations`
      imports: [PokemonSearchInputComponent],
      providers: [
        { provide: Router, useValue: mockRouter },
        { provide: PokemonService, useValue: mockPokemonService },
        { provide: AlertService, useValue: mockAlertService },
      ],
    }).compileComponents();
  });

  it('should call getPokemon and navigate to detail page on successful search', () => {
    const fixture = TestBed.createComponent(PokemonSearchInputComponent);
    const component = fixture.componentInstance;

    const mockPokemon = {
      id: 1,
      order: '1',
      name: 'bulbasaur',
      height: '7',
      weight: '69',
      sprites: {
        front_default: '',
        front_shiny: '',
      },
    };

    mockPokemonService.getPokemon.and.returnValue(of(mockPokemon));

    component.termValue.set('bulbasaur');
    component.searchPokemon();

    expect(mockPokemonService.getPokemon).toHaveBeenCalledWith('bulbasaur');
    expect(mockRouter.navigate).toHaveBeenCalledWith(['/pokemon/bulbasaur']);
  });

  it('should lowercase input before calling getPokemon', () => {
    const fixture = TestBed.createComponent(PokemonSearchInputComponent);
    const component = fixture.componentInstance;
  
    const mockPokemon = {
      id: 1,
      order: '1',
      name: 'bulbasaur',
      height: '7',
      weight: '69',
      sprites: {
        front_default: '',
        front_shiny: '',
      },
    };
  
    mockPokemonService.getPokemon.and.returnValue(of(mockPokemon));
  
    component.termValue.set(' BULBASAUR ');
    component.searchPokemon();
  
    expect(mockPokemonService.getPokemon).toHaveBeenCalledWith('bulbasaur');
  });
  it('should update termValue from input event', () => {
    const fixture = TestBed.createComponent(PokemonSearchInputComponent);
    const component = fixture.componentInstance;
  
    const input = document.createElement('input');
    input.value = 'pikachu';
  
    const mockEvent = new CustomEvent('input', {
      detail: {},
      bubbles: true,
      cancelable: true,
    });
    Object.defineProperty(mockEvent, 'target', { value: input });
  
    component.assignInputValue(mockEvent as Event);
  
    expect(component.termValue()).toBe('pikachu');
  });
  it('should reset termValue and loading state after successful search', () => {
    const fixture = TestBed.createComponent(PokemonSearchInputComponent);
    const component = fixture.componentInstance;
  
    const mockPokemon = {
      id: 1,
      order: '1',
      name: 'bulbasaur',
      height: '7',
      weight: '69',
      sprites: {
        front_default: '',
        front_shiny: '',
      },
    };
  
    mockPokemonService.getPokemon.and.returnValue(of(mockPokemon));
  
    component.termValue.set('bulbasaur');
    component.pokemonLoading.set(true);
    component.searchPokemon();
  
    expect(component.termValue()).toBe('');
    expect(component.pokemonLoading()).toBeFalse();
  });
          
});
