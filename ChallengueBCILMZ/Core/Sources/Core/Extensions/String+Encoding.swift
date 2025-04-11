//
//  String+Encoding.swift
//  Core
//
//  Created by Luis Marca on 11/04/25.
//

public extension String {
    
    func urlEncodedString() -> String? {
        addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
    var extractedPokemonID: String? {
        self.split(separator: "/").last(where: { !$0.isEmpty }).map { String($0) }
    }
}
