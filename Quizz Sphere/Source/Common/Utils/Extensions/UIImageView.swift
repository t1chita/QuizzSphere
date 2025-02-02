//
//  UIImageView.swift
//  Quizz Sphere
//
//  Created by Temur Chitashvili on 08.08.24.
//

import UIKit

extension UIImageView {
    //PNG,JPEG Formats
    func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data,
                  error == nil,
                  let image = UIImage(data: data) else { return }
            DispatchQueue.main.sync{
                self?.image = image
            }
        }.resume()
    }
}
