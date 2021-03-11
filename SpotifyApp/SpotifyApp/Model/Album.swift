//
//  Album.swift
//  SpotifyApp
//
//  Created by Jorge on 7/13/19.
//  Copyright © 2019 Jorge. All rights reserved.
//

import Foundation

struct AlbumObject: Codable {
    let items: [Album]
}

// MARK: - Album
struct Album: Codable {
    let availableMarkets: [String]?
    let externalUrls: ExternalUrls?
    let href: String?
    let id: String?
    let images: [Image]?
    let name, releaseDate: String?
    let totalTracks: Int?
    let uri: String?
    
    enum CodingKeys: String, CodingKey {
        case availableMarkets = "available_markets"
        case externalUrls = "external_urls"
        case href, id, images, name
        case releaseDate = "release_date"
        case totalTracks = "total_tracks"
        case uri
    }
}
