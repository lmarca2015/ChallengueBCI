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
    
    @Published var errorMessage: String? = nil
    @Published var pokemons: [Pokemon] = []
    
    
    // MARK: - Lifecycle
    
    init() {
        fetchPokemons()
    }
    
    
    // MARK: - Internal
    
    func fetchPokemons() {
        pokemonUseCase.execute()
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure( _):
                    self?.errorMessage = "Sin conexión y sin datos disponibles."
                case .finished:
                    break
                }
            } receiveValue: { [weak self] pokemons in
                self?.pokemons = pokemons
            }
            .store(in: &cancellables)
    }
}
