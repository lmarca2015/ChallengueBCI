//
//  GetPokemonsUseCase.swift
//  Domain
//
//  Created by Luis Marca on 11/04/25.
//

import Foundation
import Combine
import DependencyInjector

@available(iOS 13.0, *)
public protocol GetPokemonsUseCaseProtocol {
    
    func execute() -> AnyPublisher<[Pokemon], Error>
}

@available(iOS 13.0, *)
public struct GetPokemonsUseCase: GetPokemonsUseCaseProtocol {
    
    
    // MARK: - Properties
    
    @Inject private var repository: PokemonRepositoryProtocol
    
    
    // MARK: - Lifecycle
    
    public init() {}
    
    public init(repository: PokemonRepositoryProtocol) {
        self.repository = repository
    }
    
    
    // MARK: - Public
    
    public func execute() -> AnyPublisher<[Pokemon], Error> {
        repository.fetchPokemons()
    }
}
