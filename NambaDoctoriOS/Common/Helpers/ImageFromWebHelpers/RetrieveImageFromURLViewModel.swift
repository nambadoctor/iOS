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
    public var id = UUID().uuidString
    var image:UIImage? = nil
    var url:URL? = nil
    
    init(urlString:String, _ completion: @escaping (_ success:Bool)->()) {
        guard let url = URL(string: urlString) else { return }
        self.url = url
        completion(true)
        getImage()
    }
    
    func getImage () {
        URLSession.shared.dataTask(with: self.url!) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data else {
                    return
                }
                if let image = UIImage(data: data) {
                    self.image = image
                } else {
                }
            }
        }.resume()
    }
}
