//
//  PokemonRepositoryProtocol.swift
//  Domain
//
//  Created by Luis Marca on 11/04/25.
//

import Foundation
import Combine

@available(iOS 13.0, *)
public protocol PokemonRepositoryProtocol {
    
    func fetchPokemons() -> AnyPublisher<[Pokemon], Error>
    func getPokemon(by id: Int) -> AnyPublisher<Pokemon, Error>
}
