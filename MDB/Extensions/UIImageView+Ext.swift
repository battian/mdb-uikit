//
//  File.swift
//  MDB
//
//  Created by Ana Battistini on 10/08/24.
//

import UIKit

extension UIImageView {
  private static let imageCache = NSCache<NSURL, UIImage>()
  
  func loadImage(from url: URL) {
    if let cachedImage = UIImageView.imageCache.object(forKey: url as NSURL) {
      self.image = cachedImage
      return
    }
    
    DispatchQueue.global().async { [weak self] in
      if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
        DispatchQueue.main.async {
          UIImageView.imageCache.setObject(image, forKey: url as NSURL)
          self?.image = image
        }
      } else {
        DispatchQueue.main.async { self?.image = UIImage(named: "placeholder-image") }
      }
    }
  }
}

