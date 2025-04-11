//
//  UIImageView+Extensions.swift
//  Core
//
//  Created by Luis Marca on 11/04/25.
//

import UIKit

public extension UIImageView {
    
    func setImage(from url: URL) {
        if let cachedImage = ImageCacheManager.shared.image(for: url) {
            self.image = cachedImage
            return
        }

        // Sino, descarga
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self,
                  let data = data,
                  error == nil,
                  let image = UIImage(data: data) else { return }

            ImageCacheManager.shared.setImage(image, for: url)

            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
