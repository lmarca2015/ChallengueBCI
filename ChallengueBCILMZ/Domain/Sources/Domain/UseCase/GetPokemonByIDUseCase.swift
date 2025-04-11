//
//  GetPokemonByIDUseCase.swift
//  Domain
//
//  Created by Luis Marca on 11/04/25.
//

import Foundation
import Combine
import DependencyInjector

@available(iOS 13.0, *)
public protocol GetPokemonByIDUseCaseProtocol {
    
    func execute(by id: Int) -> AnyPublisher<Pokemon, Error>
}

@available(iOS 13.0, *)
public struct GetPokemonByIDUseCase: GetPokemonByIDUseCaseProtocol {
    
    
    // MARK: - Properties
    
    @Inject private var repository: PokemonRepositoryProtocol
    
    
    // MARK: - Lifecycle
    
    public init() {}
    
    public init(repository: PokemonRepositoryProtocol) {
        self.repository = repository
    }
    
    
    // MARK: - Public
    
    public func execute(by id: Int) -> AnyPublisher<Pokemon, Error> {
        repository.getPokemon(by: id)
    }
}
