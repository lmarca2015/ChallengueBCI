//
//  Dictionary+Extension.swift
//  Core
//
//  Created by Luis Marca on 11/04/25.
//

import Foundation

public extension Dictionary where Key == String, Value == Any {
    
    func urlEncodedQueryString() throws -> String {
        let queryString = try self.map { key, value in
            
            guard let encodedKey = key.urlEncodedString(),
                  let encodedValue = "\(value)".urlEncodedString() else {
                throw "Invalid encoding"
            }
            return "\(encodedKey)=\(encodedValue)"
        }
        return queryString.joined(separator: "&")
    }
}
