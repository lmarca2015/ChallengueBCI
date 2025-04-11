//
//  PokemonFormDTO.swift
//  Data
//
//  Created by Luis Marca on 11/04/25.
//

import Foundation
import Domain

struct PokemonFormDTO: Codable, DTOtoModel {
    
    var name: String
    var url: String

    var toModel: PokemonForm {
        PokemonForm(name: name, url: url)
    }
}

struct PokemonAbilityDTO: Codable, DTOtoModel {
    
    var name: String

    var toModel: PokemonAbility {
        PokemonAbility(name: name)
    }
}

struct StatNameDTO: Codable, DTOtoModel {
    
    var name: String

    var toModel: StatName {
        StatName(name: name)
    }
}

struct PokemonTypeDTO: Codable, DTOtoModel {
    
    var name: String

    var toModel: PokemonType {
        PokemonType(name: name)
    }
}

struct PokemonAbilityEntryDTO: Codable, DTOtoModel {
    
    public let ability: PokemonAbilityDTO

    var toModel: PokemonAbilityEntry {
        PokemonAbilityEntry(ability: ability.toModel)
    }
}

struct PokemonTypeEntryDTO: Codable, DTOtoModel {
    
    public let type: PokemonTypeDTO

    var toModel: PokemonTypeEntry {
        PokemonTypeEntry(type: type.toModel)
    }
}

struct PokemonStatDTO: Codable, DTOtoModel {
    
    public let base_stat: Int
    public let stat: StatNameDTO

    var toModel: PokemonStat {
        PokemonStat(base_stat: base_stat, stat: stat.toModel)
    }
}
