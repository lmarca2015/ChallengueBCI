//
//  Pokemon.swift
//  Domain
//
//  Created by Luis Marca on 11/04/25.
//

import Foundation

public struct Pokemon: Codable {
    
    public let name: String
    public let order: Int?
    public var imageURL: URL?
    public let forms: [PokemonForm]?
    public let types: [PokemonTypeEntry]?
    public let stats: [PokemonStat]?
    public let abilities: [PokemonAbilityEntry]?
    
    // MARK: - Lifecycle
    
    public init(name: String,
                order: Int? = nil,
                imageURL: URL? = nil,
                forms: [PokemonForm]? = [],
                types: [PokemonTypeEntry]? = [],
                stats: [PokemonStat]? = [],
                abilities: [PokemonAbilityEntry]? = []) {
        self.name = name
        self.order = order
        self.imageURL = imageURL
        self.forms = forms
        self.types = types
        self.stats = stats
        self.abilities = abilities
    }
}

public extension Pokemon {
    var artworkURL: URL? {
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(order ?? 1).png")
    }
}

public struct PokemonTypeEntry: Codable {
    
    public let type: PokemonType
    
    public init(type: PokemonType) {
        self.type = type
    }
}

public struct PokemonType: Codable {
    
    public let name: String
    
    public init(name: String) {
        self.name = name
    }
}

public struct PokemonStat: Codable {
    
    public let base_stat: Int
    public let stat: StatName

    public init(base_stat: Int, stat: StatName) {
        self.base_stat = base_stat
        self.stat = stat
    }
}

public struct StatName: Codable {
    
    public let name: String
    
    public init(name: String) {
        self.name = name
    }
}

public struct PokemonAbilityEntry: Codable {
    
    public let ability: PokemonAbility
    
    public init(ability: PokemonAbility) {
        self.ability = ability
    }
}

public struct PokemonAbility: Codable {
    
    public let name: String
    
    public init(name: String) {
        self.name = name
    }
}

public struct PokemonForm: Codable {
    
    public let name: String
    public let url: String
    
    public init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}
