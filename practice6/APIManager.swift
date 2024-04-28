//
//  APIManager.swift
//  practice6
//
//  Created by Yernur Adilbek on 10/20/23.
//

import UIKit
import SnapKit

class APIManager{
//    func loadImages(completion: @escaping ([UIImage?])-> ()){
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
//            completion([UIImage(systemName: "star"),UIImage(systemName: "star"),UIImage(systemName: "star"),UIImage(systemName: "star"),UIImage(systemName: "star"),UIImage(systemName: "star"), ])
//        }
//    }
    
    func fetchImagesFromPixabay(apiKey: String, query: String, completion: @escaping ([String]?) -> Void) {
        let baseURL = "https://pixabay.com/api/"
        let apiKey = "40163863-36bc58c6c931d922a825ef931"
        
        let parameters: [String: Any] = [
            "key": apiKey,
            "q": query,
            "image_type": "photo" // You can adjust the search parameters as needed
        ]
        
        guard let url = URL(string: baseURL)?.appendingQueryParameters(parameters) else {
            completion(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(PixabayResponse.self, from: data)
                let imageUrls = response.hits.map { $0.webformatURL }
                completion(imageUrls)
            } catch {
                completion(nil)
            }
        }
        task.resume()
    }
    
    struct PixabayResponse: Codable {
        let hits: [PixabayImage]
    }

    struct PixabayImage: Codable {
        let webformatURL: String
    }
    
    fetchImagesFromPixabay(apiKey: "40163863-36bc58c6c931d922a825ef931", query: "nature") { imageUrls in
        if let imageUrls = imageUrls {
            // Handle the retrieved image URLs
            print(imageUrls)
        } else {
            // Handle the error
            print("Failed to fetch images from Pixabay")
        }
    }

}
