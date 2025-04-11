//
//  PokemonListViewModel.swift
//  ChallengueBCILMZ
//
//  Created by Luis Marca on 11/04/25.
//

import Foundation
import Combine
import DependencyInjector
import Domain

final class PokemonListViewModel: ObservableObject {
    
    
    // MARK: - Properties Injected
    
    @Inject private var pokemonUseCase: GetPokemonsUseCaseProtocol
    
    
    // MARK: - Properties
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var pokemons: [Pokemon] = []
    @Published var searchedPokemons: [Pokemon] = []
    @Published var searchText: String = ""
    
    
    // MARK: - Lifecycle
    
    init() {
        $searchText
            .debounce(for: .seconds(0.75), scheduler: RunLoop.main)
            .sink { [weak self] newValue in
                if newValue.isEmpty {
                    //self?.searchedRecipes.removeAll()
                } else {
                    //self?.filterRecipies()
                }
            }
            .store(in: &cancellables)
        fetchPokemons()
    }
    
    
    // MARK: - Internal
    
    func fetchPokemons() {
        pokemonUseCase.execute()
            .receive(on: RunLoop.main)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] pokemons in
                guard let self = self else { return }
                self.pokemons = pokemons
            }
            .store(in: &cancellables)
    }
    
}
