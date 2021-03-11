//
//  APIService.swift
//  SpotifyApp
//
//  Created by Jorge on 7/13/19.
//  Copyright © 2019 Jorge. All rights reserved.
//

import Foundation
import Alamofire

protocol APIServiceProtocol {
    func fetchArtist(byName name:String, complete: @escaping (Artists?, Error?) -> ())
    func fetchAlbums(byArtist id:String, complete: @escaping ([Album]?, Error?) -> ())
}

class APIService: APIServiceProtocol {
    func fetchArtist(byName name: String, complete: @escaping (Artists?, Error?) -> ()) {
        let url = Constants.SpotifyUrlBase + Constants.SpotifySearchMethod + "q=" + name + "&type=artist&market=US&limit=10&offset=5"
       
        guard let encodedURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        let headers: HTTPHeaders = [
            Constants.spotifyBearerKey: Constants.spotifyBearer
        ]
        
        Alamofire.request(encodedURL, headers: headers).validate().responseJSON { (response: DataResponse) in
            switch response.result{
            case.success:
                if let payload = response.data {
                    let decoder = JSONDecoder()
                    let artists = try! decoder.decode(Welcome.self, from: payload)
                    print(artists)
                    complete(artists.artists, nil)
                }
            case .failure(let error):
                complete(nil, error)
            }
        }
    }
    
    func fetchAlbums(byArtist id:String, complete: @escaping ([Album]?, Error?) -> ()) {
        let url = Constants.SpotifyUrlBase + Constants.SpotifyArtistsMethod + id + "/albums?limit=10&offset=5"
        
        guard let encodedURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return
        }
        
        let headers: HTTPHeaders = [
            Constants.spotifyBearerKey: Constants.spotifyBearer
        ]
        
        Alamofire.request(encodedURL, headers: headers).validate().responseJSON { (response: DataResponse) in
            switch response.result{
            case.success:
                if let payload = response.data {
                    let decoder = JSONDecoder()
                    let albumObject = try! decoder.decode(AlbumObject.self, from: payload)
                    print(albumObject)
                    complete(albumObject.items, nil)
                }
            case .failure(let error):
                complete(nil, error)
            }
        }
    }
}
