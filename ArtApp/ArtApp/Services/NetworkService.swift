//
//  NetworkService.swift
//  ArtApp
//
//  Created by Алексей on 30.05.2024.
//

import Foundation

enum UrlAddress {
    static let url = "https://cdn.accelonline.io/OUR6G_IgJkCvBg5qurB2Ag/files/YPHn3cnKEk2NutI6fHK04Q.json"
}

final class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    func fetchArtists(completion: @escaping (ArtistItem?) -> Void) {
        let url = URL(string: UrlAddress.url)
        guard let url else {
            print("url incorrect")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "URLSession fail")
                return
            }
            
            if let jsonData = data {
                let responseData = try? JSONDecoder().decode(ArtistItem.self, from: jsonData)
                completion(responseData)
            }
            
        }.resume()
    }
    
}
