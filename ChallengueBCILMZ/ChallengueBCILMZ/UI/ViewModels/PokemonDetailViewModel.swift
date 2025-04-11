//
//  PokemonDetailViewModel.swift
//  ChallengueBCILMZ
//
//  Created by Luis Marca on 11/04/25.
//

import Foundation
import Combine
import DependencyInjector
import Domain

final class PokemonDetailViewModel: ObservableObject {
    
    
    // MARK: - Properties Injected
    
    @Inject private var pokemonByIDUseCase: GetPokemonByIDUseCaseProtocol
    
    
    // MARK: - Properties
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published var pokemon: Pokemon?
    let pokemonId: Int
    
    
    // MARK: - Lifecycle
    
    init(pokemonId: Int) {
        self.pokemonId = pokemonId
    }
    
    func handleOnAppear() {
        fetchPokemonByID()
    }
    
    
    // MARK: - Internal
    
    func fetchPokemonByID() {
        pokemonByIDUseCase.execute(by: pokemonId)
            .receive(on: RunLoop.main)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] pokemon in
                guard let self = self else { return }
                self.pokemon = pokemon
            }
            .store(in: &cancellables)
    }
}
