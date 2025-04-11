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
    
    
    // MARK: - Lifecycle
    
    init() {
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
