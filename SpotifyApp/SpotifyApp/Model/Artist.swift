//
//  Artist.swift
//  SpotifyApp
//
//  Created by Jorge on 7/13/19.
//  Copyright © 2019 Jorge. All rights reserved.
//

import Foundation

struct Welcome: Codable {
    let artists: Artists
}

// MARK: - Artists
struct Artists: Codable {
    let items: [Artist]
}

// MARK: - Item
struct Artist: Codable {
    let externalUrls: ExternalUrls?
    let followers: Followers
    let href: String
    let id: String
    let images: [Image]
    let name: String
    let popularity: Int
    
    enum CodingKeys: String, CodingKey {
        case externalUrls = "external_urls"
        case followers, href, id, images, name, popularity
    }
}

// MARK: - ExternalUrls
struct ExternalUrls: Codable {
    let spotify: String
}

// MARK: - Followers
struct Followers: Codable {
    let total: Int
}

// MARK: - Image
struct Image: Codable {
    let height: Int
    let url: String
    let width: Int
}
