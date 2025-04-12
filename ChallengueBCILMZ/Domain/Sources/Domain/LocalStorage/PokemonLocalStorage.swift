//
//  PokemonLocalStorage.swift
//  Core
//
//  Created by Luis Marca on 12/04/25.
//

import Domain
import Foundation

public final class PokemonLocalStorage {
    
    private let fileManager = FileManager.default
    private let listFilename = "pokemons.json"

    public init() {}

    public func savePokemonList(_ pokemons: [Pokemon]) {
        let url = getURL(for: listFilename)
        if let data = try? JSONEncoder().encode(pokemons) {
            try? data.write(to: url)
        }
    }

    public func loadPokemonList() -> [Pokemon]? {
        let url = getURL(for: listFilename)
        guard let data = try? Data(contentsOf: url) else { return nil }
        return try? JSONDecoder().decode([Pokemon].self, from: data)
    }

    public func savePokemonDetail(_ pokemon: Pokemon) {
        let url = getURL(for: "pokemon_\(pokemon.extractedID).json")
        if let data = try? JSONEncoder().encode(pokemon) {
            try? data.write(to: url)
        }
    }

    public func loadPokemonDetail(id: Int) -> Pokemon? {
        let url = getURL(for: "pokemon_\(id).json")
        guard let data = try? Data(contentsOf: url) else { return nil }
        return try? JSONDecoder().decode(Pokemon.self, from: data)
    }

    
    // MARK: - Helpers
    
    private func getURL(for filename: String) -> URL {
        fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(filename)
    }
}
