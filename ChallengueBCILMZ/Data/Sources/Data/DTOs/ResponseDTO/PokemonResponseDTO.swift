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
    
    var id: Int
    var name: String
    var forms: [PokemonFormDTO]
    var types: [PokemonTypeEntryDTO]
    var stats: [PokemonStatDTO]
    var abilities: [PokemonAbilityEntryDTO]
    
    
    // MARK: - DTOtoModel
    
    var toModel: Pokemon {
        let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png")

        return Pokemon(id: id,
                name: "",
                imageURL: url,
                forms: forms.map({ $0.toModel }),
                types: types.map({ $0.toModel }),
                stats: stats.map({ $0.toModel }),
                abilities: abilities.map({ $0.toModel }))
    }
}
