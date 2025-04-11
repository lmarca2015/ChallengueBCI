//
//  Encodable+Extension.swift
//  Core
//
//  Created by Luis Marca on 11/04/25.
//

import Foundation
import os.log

@available(iOS 14.0, *)
public extension Encodable {
    
    var asDictionary: [String: Any]? {
        do {
            let jsonData = try JSONEncoder().encode(self)
            guard let dictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else {
                return nil
            }
            return dictionary
        } catch {
            os_log(.error, "Error encoding struct to dictionary: \(error)")
            return nil
        }
    }
    
}
