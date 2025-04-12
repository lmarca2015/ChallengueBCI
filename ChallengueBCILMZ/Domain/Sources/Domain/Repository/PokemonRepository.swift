//
//  PokemonRepository.swift
//  Domain
//
//  Created by Luis Marca on 11/04/25.
//

import Foundation
import Combine
import DependencyInjector

@available(iOS 13.0.0, *)
public struct PokemonRepository: PokemonRepositoryProtocol {
    
    
    // MARK: - Properties
    
    @Inject private var remoteDS: PokemonRemoteDataSourceProtocol
    private let localStorage = PokemonLocalStorage()
    
    
    // MARK: - Lifecycle
    
    public init() {}
    
    public init(remoteDS: PokemonRemoteDataSourceProtocol) {
        self.remoteDS = remoteDS
    }
    
    
    // MARK: - RecipeRepositoryProtocol
    
    public func fetchPokemons() -> AnyPublisher<[Pokemon], Error> {
        Deferred {
            Future<[Pokemon], Error> { promise in
                Task {
                    do {
                        if let localPokemons = localStorage.loadPokemonList(), !localPokemons.isEmpty {
                            promise(.success(localPokemons))
                            return
                        }
                        
                        let pokemons = try await remoteDS.fetchPokemons()
                        localStorage.savePokemonList(pokemons)
                        promise(.success(pokemons))
                    } catch {
                        promise(.failure(error))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    public func getPokemon(by id: Int) -> AnyPublisher<Pokemon, Error> {
        Deferred {
            Future { promise in
                Task {
                    do {
                        if let cachedDetail = localStorage.loadPokemonDetail(id: id) {
                            promise(.success(cachedDetail))
                            return
                        }
                        
                        let pokemon = try await remoteDS.getPokemon(by: id)
                        localStorage.savePokemonDetail(pokemon)
                        promise(.success(pokemon))
                    } catch {
                        // TODO: manage error
                        promise(.failure(error))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
}
