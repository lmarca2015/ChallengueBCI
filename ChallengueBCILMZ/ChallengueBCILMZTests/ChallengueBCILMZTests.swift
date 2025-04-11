//
//  ChallengueBCILMZTests.swift
//  ChallengueBCILMZTests
//
//  Created by Luis Marca on 10/04/25.
//

import Testing
@testable import ChallengueBCILMZ

struct ChallengueBCILMZTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }
    
    @Test func testGetAllPokemonsSuccess() async throws {
        let mock = MockPokemonRemoteDataSource()
        let pokemons = try await mock.fetchPokemons()

        #expect(!pokemons.isEmpty, "The list should not be empty")
        #expect(pokemons.count == 4, "Should return exactly 4 pokemons")
        #expect(pokemons.first?.name == "Bulbasaur")
    }

    @Test func testGetPokemonByIdSuccess() async throws {
        let mock = MockPokemonRemoteDataSource()
        let pikachu = try await mock.getPokemon(by: 1)

        #expect(pikachu.name == "Bulbasaur")
        #expect(pikachu.types?.first?.type.name == "grass")
    }

    @Test func testGetPokemonByIdNotFound() async throws {
        let mock = MockPokemonRemoteDataSource()

        do {
            _ = try await mock.getPokemon(by: 999)
            #expect(false, "Expected an error for not found")
        } catch {
            #expect(error as? PokemonError == .pokemonNotFound)
        }
    }

    @Test func testGetPokemonsError() async throws {
        let mock = MockPokemonRemoteDataSource()
        mock.shouldReturnError = true

        do {
            _ = try await mock.fetchPokemons()
            #expect(false, "Expected error but got success")
        } catch {
            #expect(error as? PokemonError == .failedRequest)
        }
    }
}

