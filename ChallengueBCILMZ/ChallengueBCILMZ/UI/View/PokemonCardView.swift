//
//  PokemonCardView.swift
//  ChallengueBCILMZ
//
//  Created by Luis Marca on 11/04/25.
//

import UIKit
import Domain
import Kingfisher

final class PokemonCardView: UIView {
    
    
    // MARK: - Subviews
    
    private lazy var backgroundCard: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemPurple
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var pokemonImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.shadowColor = UIColor.black.cgColor
        iv.layer.shadowOpacity = 0.2
        iv.layer.shadowOffset = CGSize(width: 0, height: 2)
        iv.layer.shadowRadius = 4
        return iv
    }()
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .darkGray
        label.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var typeStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let graphButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Ver Gráfica", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with pokemon: Pokemon) {
        if let forms = pokemon.forms, !forms.isEmpty {
            guard let first = forms.first,
                  let pokemonId = first.url.extractedPokemonID  else { return }
            
            numberLabel.text = "#\(pokemonId)"
            nameLabel.text = first.name.capitalized
            
            typeStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
            
            if let types = pokemon.types {
                for type in types {
                    let circle = UIView()
                    circle.translatesAutoresizingMaskIntoConstraints = false
                    circle.widthAnchor.constraint(equalToConstant: 20).isActive = true
                    circle.heightAnchor.constraint(equalToConstant: 20).isActive = true
                    circle.layer.cornerRadius = 10
                    circle.backgroundColor = color(for: type.type.name)
                    typeStackView.addArrangedSubview(circle)
                }
                
                if let mainType = types.first?.type.name {
                    backgroundCard.backgroundColor = backgroundColor(for: mainType)
                }
            }
            
            guard let url = URL(string: "\(PokemonTableViewCell.imageBaseURL)/\(pokemonId).png") else { return }
            
            pokemonImageView.kf.setImage(with: url)
        } else {
            guard let url = pokemon.url,
                  let pokemonId = url.extractedPokemonID  else { return }
            
            numberLabel.text = "#\(pokemonId)"
            nameLabel.text = pokemon.name?.capitalized
            
            guard let url = URL(string: "\(PokemonTableViewCell.imageBaseURL)/\(pokemonId).png") else { return }
            
            pokemonImageView.kf.setImage(with: url)
        }
    }
}


// MARK: - Private methods

private extension PokemonCardView {
    
    func setupView() {
        addSubview(backgroundCard)
        addSubview(pokemonImageView)
        backgroundCard.addSubview(numberLabel)
        backgroundCard.addSubview(nameLabel)
        backgroundCard.addSubview(typeStackView)
        backgroundCard.addSubview(graphButton)
        
        NSLayoutConstraint.activate([
            backgroundCard.topAnchor.constraint(equalTo: topAnchor, constant: 120),
            backgroundCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            backgroundCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            backgroundCard.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            pokemonImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            pokemonImageView.topAnchor.constraint(equalTo: topAnchor),
            pokemonImageView.widthAnchor.constraint(equalToConstant: 300),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 300),
            
            numberLabel.topAnchor.constraint(equalTo: pokemonImageView.bottomAnchor, constant: 12),
            numberLabel.centerXAnchor.constraint(equalTo: backgroundCard.centerXAnchor),
            numberLabel.widthAnchor.constraint(equalToConstant: 60),
            numberLabel.heightAnchor.constraint(equalToConstant: 20),
            
            nameLabel.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 8),
            nameLabel.centerXAnchor.constraint(equalTo: backgroundCard.centerXAnchor),
            
            typeStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 12),
            typeStackView.centerXAnchor.constraint(equalTo: backgroundCard.centerXAnchor),
            
            graphButton.topAnchor.constraint(equalTo: typeStackView.bottomAnchor, constant: 16),
            graphButton.centerXAnchor.constraint(equalTo: backgroundCard.centerXAnchor),
            graphButton.widthAnchor.constraint(equalToConstant: 100),
            graphButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func color(for typeName: String) -> UIColor {
        switch typeName.lowercased() {
        case "fire": return .systemRed
        case "water": return .systemBlue
        case "grass": return .systemGreen
        case "electric": return .systemYellow
        case "normal": return .systemGray
        case "poison": return .systemPurple
        case "flying": return .systemTeal
        default: return .white
        }
    }
    
    func backgroundColor(for typeName: String) -> UIColor {
        switch typeName.lowercased() {
        case "grass": return UIColor(red: 170/255, green: 212/255, blue: 60/255, alpha: 1)
        case "fire": return UIColor(red: 255/255, green: 140/255, blue: 60/255, alpha: 1)
        case "water": return UIColor(red: 100/255, green: 170/255, blue: 255/255, alpha: 1)
        case "poison": return UIColor(red: 200/255, green: 100/255, blue: 170/255, alpha: 1)
        case "electric": return UIColor(red: 255/255, green: 215/255, blue: 50/255, alpha: 1)
        case "bug": return UIColor(red: 140/255, green: 200/255, blue: 40/255, alpha: 1)
        case "flying": return UIColor(red: 180/255, green: 160/255, blue: 255/255, alpha: 1)
        case "normal": return UIColor(red: 230/255, green: 220/255, blue: 210/255, alpha: 1)
        default: return UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
        }
    }
}
