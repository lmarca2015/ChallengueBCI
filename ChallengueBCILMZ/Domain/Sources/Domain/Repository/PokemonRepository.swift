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
                        let pokemons = try await remoteDS.fetchPokemons()
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
                        let recipe = try await remoteDS.getPokemon(by: id)
                        promise(.success(recipe))
                    } catch {
                        // TODO: manage error
                        promise(.failure(error))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
}
