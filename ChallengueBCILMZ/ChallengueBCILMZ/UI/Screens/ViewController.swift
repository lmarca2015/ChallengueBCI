//
//  ViewController.swift
//  ChallengueBCILMZ
//
//  Created by Luis Marca on 10/04/25.
//

import UIKit
import Combine
import Domain
class ViewController: UIViewController {
    
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

    private var viewModel = PokemonListViewModel()
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
        setupTableView()
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokemons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableViewCell.identifier, for: indexPath) as? PokemonTableViewCell else {
            return UITableViewCell()
        }
        
        let pokemon = pokemons[indexPath.row]
        cell.configure(with: pokemon, index: indexPath.row)
        return cell
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
    
    private func bindViewModel() {
         viewModel.$pokemons
             .receive(on: RunLoop.main)
             .sink { [weak self] response in
                 guard let self else  { return }
                 pokemons = response
             }
             .store(in: &cancellables)
     }
}
