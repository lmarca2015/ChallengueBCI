//
//  DetailViewController.swift
//  ChallengueBCILMZ
//
//  Created by Luis Marca on 11/04/25.
//

import UIKit
import Combine
import Domain

class DetailViewController: UIViewController, LoadingViewPresentable {
    
    private let viewModel: PokemonDetailViewModel
    private var cancellables = Set<AnyCancellable>()
    private let cardView = PokemonCardView()
    
    private var pokemon: Pokemon?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bindViewModel()
        setupUI()
        viewModel.handleOnAppear()
    }
    
    init(viewModel: PokemonDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension DetailViewController {
    
    func setupUI() {
        view.backgroundColor = .white

        cardView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cardView)

        NSLayoutConstraint.activate([
            cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cardView.widthAnchor.constraint(equalToConstant: 400),
            cardView.heightAnchor.constraint(equalToConstant: 680)
        ])
    }
    
    func bindViewModel() {
        showLoading()
        viewModel.$pokemon
            .receive(on: RunLoop.main)
            .sink { [weak self] response in
                guard let self, let response else { return }
                hideLoading()
                
                cardView.configure(with: response)
            }
            .store(in: &cancellables)
    }
    
}

extension DetailViewController {
    
    static func build(pokemonId: Int) -> DetailViewController {
        let viewModel = PokemonDetailViewModel(pokemonId: pokemonId)
        
        return DetailViewController(viewModel: viewModel)
    }
}
