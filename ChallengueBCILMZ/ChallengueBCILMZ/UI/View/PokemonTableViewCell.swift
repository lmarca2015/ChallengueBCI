//
//  PokemonTableViewCell.swift
//  ChallengueBCILMZ
//
//  Created by Luis Marca on 11/04/25.
//

import UIKit
import Domain
import Core

class PokemonTableViewCell: UITableViewCell {
    
    static let identifier = "PokemonTableViewCell"
    static let imageBaseURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork"
    
    private var currentImageURL: URL?
    
    private lazy var pokemonImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 24
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(pokemonImageView)
        contentView.addSubview(numberLabel)
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            pokemonImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            pokemonImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            pokemonImageView.widthAnchor.constraint(equalToConstant: 48),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 48),
            
            numberLabel.leadingAnchor.constraint(equalTo: pokemonImageView.trailingAnchor, constant: 16),
            numberLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -10),
            numberLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            
            nameLabel.leadingAnchor.constraint(equalTo: numberLabel.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 4),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    func configure(with pokemon: Pokemon) {
        guard let name = pokemon.name, let url = pokemon.url, let pokemonId = url.extractedPokemonID else { return }
        
        numberLabel.text = "#\(pokemonId)"
        nameLabel.text = name.capitalized
        
        pokemonImageView.image = nil
        
        guard let url = URL(string: "\(PokemonTableViewCell.imageBaseURL)/\(pokemonId).png") else { return }
        currentImageURL = url

        downloadImage(from: url, into: pokemonImageView)
    }
    
    func downloadImage(from url: URL, into imageView: UIImageView) {
        if let cachedImage = ImageCacheManager.shared.image(for: url) {
            imageView.image = cachedImage
            return
        }

        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self else { return }
            guard let data, error == nil,
                  let image = UIImage(data: data) else { return }

            ImageCacheManager.shared.setImage(image, for: url)

            DispatchQueue.main.async {
                if self.currentImageURL == url {
                    imageView.image = image
                }
            }
        }.resume()
    }

}
