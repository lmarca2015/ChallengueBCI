//
//  DTOtoModel.swift
//  Data
//
//  Created by Luis Marca on 11/04/25.
//

protocol DTOtoModel {
    
    associatedtype Model
    
    var toModel: Model { get }
}
