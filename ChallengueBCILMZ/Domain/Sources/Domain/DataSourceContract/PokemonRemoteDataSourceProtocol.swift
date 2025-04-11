//
//  PokemonRemoteDataSourceProtocol.swift
//  Domain
//
//  Created by Luis Marca on 11/04/25.
//

import Foundation

@available(iOS 13.0, *)
public protocol PokemonRemoteDataSourceProtocol {
    
    func fetchPokemons() async throws -> [Pokemon]
    func getPokemon(by id: Int) async throws -> Pokemon
}
