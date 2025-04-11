//
//  PokemonDependencies.swift
//  ChallengueBCILMZ
//
//  Created by Luis Marca on 11/04/25.
//

import Foundation
import DependencyInjector
import Domain
import Data

struct PokemonDependencies {
    
    init() {
        
        
        // MARK: Datasources
        @Provider var pokemonRemoteDS = PokemonRemoteDataSource() as PokemonRemoteDataSourceProtocol

        
        // MARK: Repositories
        @Provider var pokemonRepository = PokemonRepository() as PokemonRepositoryProtocol

        
        // MARK: UseCases
        @Provider var listUseCase = GetPokemonsUseCase() as GetPokemonsUseCaseProtocol
        @Provider var getIndividualUseCase = GetPokemonByIDUseCase() as GetPokemonByIDUseCaseProtocol
    }
}
