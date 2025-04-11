//
//  String+Error.swift
//  Core
//
//  Created by Luis Marca on 11/04/25.
//

import Foundation

extension String: Error {}

extension String: LocalizedError {
    
    public var errorDescription: String? {
        self
    }
}
