//
//  PokemonResponseDTO.swift
//  Data
//
//  Created by Luis Marca on 11/04/25.
//

import Foundation
import Domain

struct PokemonResponseDTO: Codable, DTOtoModel {
    
    
    // MARK: - Properties
    
    var forms: [PokemonFormDTO]
    var types: [PokemonTypeEntryDTO]
    var stats: [PokemonStatDTO]
    var abilities: [PokemonAbilityEntryDTO]
    var weight: Int
    
    // MARK: - DTOtoModel
    
    var toModel: Pokemon {
        Pokemon(weight: weight,
                forms: forms.map({ $0.toModel }),
                types: types.map({ $0.toModel }),
                stats: stats.map({ $0.toModel }),
                abilities: abilities.map({ $0.toModel }))
    }
}
