//
//  ViewController.swift
//  ChallengueBCILMZ
//
//  Created by Luis Marca on 10/04/25.
//

import UIKit
import Combine
import Domain

class ViewController: UIViewController, LoadingViewPresentable {
    
    private var pokemons: [Pokemon] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var tableView = UITableView() {
        didSet {
            tableView.backgroundColor = .white
        }
    }
    
    private let searchController = UISearchController(searchResultsController: nil)

    private var filteredPokemons: [Pokemon] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var isSearchActive: Bool {
        !(searchController.searchBar.text?.isEmpty ?? true)
    }

    private var viewModel = PokemonListViewModel()
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
        setupTableView()
        setupSearchController()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isSearchActive ? filteredPokemons.count : pokemons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.identifier, for: indexPath) as? PokemonTableViewCell else {
            return UITableViewCell()
        }
        let list = isSearchActive ? filteredPokemons : pokemons
        let pokemon = list[indexPath.row]
        
        cell.configure(with: pokemon)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let list = isSearchActive ? filteredPokemons : pokemons
        let pokemon = list[indexPath.row]
        
        guard let url = pokemon.url, let pokemonID = url.extractedPokemonID?.toInt else { return }
        
        let controller = DetailViewController.build(pokemonId: pokemonID)
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

private extension ViewController {
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: PokemonTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Pokémon"
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func bindViewModel() {
        showLoading()
         viewModel.$pokemons
             .receive(on: RunLoop.main)
             .sink { [weak self] response in
                 guard let self else  { return }
                 hideLoading()

                 pokemons = response
             }
             .store(in: &cancellables)
     }
}

extension ViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased(), !searchText.isEmpty else {
            filteredPokemons = []
            tableView.reloadData()
            return
        }

        filteredPokemons = pokemons.filter { pokemon in
            if let name = pokemon.name?.lowercased() {
                return name.contains(searchText)
            }
            return false
        }
        
        tableView.reloadData()
    }
}

extension ViewController: UISearchBarDelegate {

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredPokemons.removeAll()
        tableView.reloadData()
    }
}
