//
//  PokemonFilteredResponseDTO.swift
//  Data
//
//  Created by Luis Marca on 11/04/25.
//

import Foundation
import Domain

struct RecipeFilteredResponseDTO: Codable, DTOtoModel {
    
    
    // MARK: - Properties
    
    var id: Int
    var name: String
    
    
    // MARK: - DTOtoModel
    
    var toModel: Pokemon {
        Pokemon(id: id, name: name)
    }
}
