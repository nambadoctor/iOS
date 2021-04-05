//
//  ImageLoaderFromWeb.swift
//  NambaDoctoriOS
//
//  Created by Surya Manivannan on 3/27/21.
//

import Foundation
import Combine
import SwiftUI

class ImageLoader: ObservableObject {
    
    @Published var image:UIImage? = nil
    
    init(urlString:String, _ completion: @escaping (_ success:Bool)->()) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data else {
                    completion(false)
                    return
                }
                if let image = UIImage(data: data) {
                    self.image = image
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
        task.resume()
    }
}
