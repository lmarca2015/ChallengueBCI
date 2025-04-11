//
//  LoadingViewPresentable.swift
//  ChallengueBCILMZ
//
//  Created by Luis Marca on 11/04/25.
//

import UIKit

protocol LoadingViewPresentable {
    
    var isLoading: Bool { get }
    
    func showLoading()
    func hideLoading()
}

extension LoadingViewPresentable where Self: UIViewController {
    
    var isLoading: Bool {
        get {
            return isLoadingViewVisible
        }
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            guard !isLoadingViewVisible else { return }

            let window = UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first { $0.isKeyWindow }

            guard let window else { return }

            loadingView = LoadingView(frame: window.bounds)
            loadingView.translatesAutoresizingMaskIntoConstraints = false
            isLoadingViewVisible = true

            window.addSubview(loadingView)
            
            NSLayoutConstraint.activate([
                loadingView.topAnchor.constraint(equalTo: window.topAnchor),
                loadingView.bottomAnchor.constraint(equalTo: window.bottomAnchor),
                loadingView.leadingAnchor.constraint(equalTo: window.leadingAnchor),
                loadingView.trailingAnchor.constraint(equalTo: window.trailingAnchor)
            ])
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            loadingView?.removeFromSuperview()
            loadingView = nil
            isLoadingViewVisible = false
        }
    }
}

private var loadingView: LoadingView!
private var isLoadingViewVisible = false
