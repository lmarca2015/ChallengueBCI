//
//  Bundle+Extension.swift
//  Core
//
//  Created by Luis Marca on 11/04/25.
//

import Foundation

public extension Bundle {
    
    var baseURL: String {
        guard let baseURL = object(forInfoDictionaryKey: "BASE_URL") as? String else {
            return ""
        }
        return baseURL
    }
    
    var apikey: String {
        guard let apikey = object(forInfoDictionaryKey: "API_KEY") as? String else {
            return ""
        }
        return apikey
    }
}
