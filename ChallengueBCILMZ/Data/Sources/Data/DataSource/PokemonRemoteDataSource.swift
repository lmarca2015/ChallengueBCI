//
//  PokemonRemoteDataSource.swift
//  Data
//
//  Created by Luis Marca on 11/04/25.
//

import Foundation
import CoreLocation
import Domain
import Core

@available(iOS 14.0.0, *)
public struct PokemonRemoteDataSource: PokemonRemoteDataSourceProtocol {

    
    // MARK: Lifecycle
    
    public init() {}
    
    
    // MARK: - PokemonRemoteDataSourceProtocol
    
    public func fetchPokemons() async throws -> [Pokemon] {
        let request = PokemonsRequest(id: 151)
        let dto = try await API().execute(request: request)
        return dto.toModel
    }
    
    public func getPokemon(by id: Int) async throws -> Pokemon {
        let request = PokemonInformationRequest(id: id)
        let dto = try await API().execute(request: request)
        return dto.toModel
    }
}
