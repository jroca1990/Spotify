//
//  Country.swift
//  SpotifyApp
//
//  Created by Jorge on 7/13/19.
//  Copyright © 2019 Jorge. All rights reserved.
//

import Foundation

struct Countries: Codable {
    let countries: [Country]
}

struct Country: Codable {
    let name: String
    let code: String
}
