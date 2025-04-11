//
//  PokemonListResponseDTO.swift
//  Data
//
//  Created by Luis Marca on 11/04/25.
//

import Foundation
import Domain

struct PokemonListResponseDTO: Decodable, DTOtoModel {
    
    
    // MARK: - Properties
    
    var results: [RecipeFilteredResponseDTO]
    var count: Int
    var next: String

    
    // MARK: - DTOtoModel
    
    var toModel: [Pokemon] {
        results.map({ $0.toModel })
    }
}
