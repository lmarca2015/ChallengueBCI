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
    private let fallbackPokemon: Pokemon?
    
    @Published var errorMessage: String? = nil
    @Published var pokemon: Pokemon?
    
    let pokemonId: Int
    
    
    // MARK: - Lifecycle
    
    init(pokemonId: Int, fallbackPokemon: Pokemon? = nil) {
        self.pokemonId = pokemonId
        self.fallbackPokemon = fallbackPokemon
    }
    
    func handleOnAppear() {
        fetchPokemonByID()
    }
    
    
    // MARK: - Internal
    
    func fetchPokemonByID() {
        pokemonByIDUseCase.execute(by: pokemonId)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                if case .failure(_) = completion {
                    guard let self = self else { return }
                    if let fallback = fallbackPokemon {
                        pokemon = fallback
                    } else {
                        errorMessage = "Sin conexión y sin datos disponibles."
                    }
                }
            } receiveValue: { [weak self] pokemon in
                guard let self = self else { return }
                self.pokemon = pokemon
            }
            .store(in: &cancellables)
    }
}
