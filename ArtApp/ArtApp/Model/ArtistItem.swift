//
//  ArtistItem.swift
//  ArtApp
//
//  Created by Алексей on 30.05.2024.
//

import Foundation

struct ArtistItem: Codable {
    let artists: [Artist]
}

struct Artist: Codable {
    let name, bio, image: String
    let works: [Work]
}

struct Work: Codable {
    let title, image, info: String
}
