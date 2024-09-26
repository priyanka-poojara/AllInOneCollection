//
//  ImageLoadExtension.swift
//  IlaBankTask
//
//  Created by Neosoft on 02/09/24.
//

import UIKit

extension UIImageView {
    func loadImage(from url: URL, placeholder: UIImage? = nil) {
        self.image = placeholder
        
        // Create a data task to fetch the image data from the URL
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else {
                print("Failed to load image from url: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            // Create a UIImage from the data
            if let image = UIImage(data: data) {
                // Update the UIImageView on the main thread
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
    }
}
