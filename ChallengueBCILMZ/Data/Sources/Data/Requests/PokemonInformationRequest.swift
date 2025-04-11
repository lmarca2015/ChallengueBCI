//
//  PokemonInformationRequest.swift
//  Data
//
//  Created by Luis Marca on 11/04/25.
//

import Foundation

@available(iOS 14.0.0, *)
struct PokemonInformationRequest: GetRequest {
    
    typealias Response = PokemonResponseDTO
    
    
    // MARK: - Properties
    
    var id: Int
    
    var body: EmptyBodyDTO = EmptyBodyDTO()
    
    var path: String {
        return "/pokemon/\(id)"
    }
    
    
    // MARK: - Lifecycle
    
    init(id: Int) {
        self.id = id
    }
}
