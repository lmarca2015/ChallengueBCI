//
//  MockPokemonRemoteDataSource.swift
//  ChallengueBCILMZ
//
//  Created by Luis Marca on 11/04/25.
//

import Foundation
import Testing
@testable import ChallengueBCILMZ
@testable import Domain

@available(iOS 13.0, *)
final class MockPokemonRemoteDataSource: PokemonRemoteDataSourceProtocol {
    
    var shouldReturnError = false
    
    private let samplePokemons: [Pokemon] = [
        Pokemon(name: "Bulbasaur", forms: [PokemonForm(name: "bulbasaur",
                                                       url: "https://pokeapi.co/api/v2/pokemon/1/")],
                types: [PokemonTypeEntry(type: PokemonType(name: "grass"))]
               ),
        Pokemon(name: "Charmander", types: [.init(type: .init(name: "fire"))]),
        Pokemon(name: "Squirtle", types: [.init(type: .init(name: "water"))]),
        Pokemon(name: "Pikachu", types: [.init(type: .init(name: "electric"))])
    ]
    
    func fetchPokemons() async throws -> [Domain.Pokemon] {
        if shouldReturnError {
            throw PokemonError.failedRequest
        }
        return samplePokemons
    }
    
    func getPokemon(by id: Int) async throws -> Pokemon {
        if shouldReturnError {
            throw PokemonError.failedRequest
        }

        guard let pokemon = samplePokemons.first(where: { $0.extractedID == id }) else {
            throw PokemonError.pokemonNotFound
        }

        return pokemon
    }
}

enum PokemonError: Error, Equatable {
    
    case failedRequest
    case pokemonNotFound
}
