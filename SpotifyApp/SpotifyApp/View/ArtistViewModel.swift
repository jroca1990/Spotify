//
//  ArtistViewModel.swift
//  SpotifyApp
//
//  Created by Jorge on 7/13/19.
//  Copyright © 2019 Jorge. All rights reserved.
//

import Foundation

class ArtistViewModel {
    let apiService: APIServiceProtocol
    var items: [Artist] = [Artist]()
    var selectedItem: Artist?

    var reloadTableViewClosure: (()->())?
    var showAlertClosure: (( _ message: String )->())?
    var updateLoadingStatus: ((Bool)->())?
    
    var cellViewModels: [ArtistListCellViewModel] = [ArtistListCellViewModel]()

    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    init(apiService: APIServiceProtocol ) {
        self.apiService = apiService
    }
    
    func getArtistBy(name: String) {
        self.updateLoadingStatus?( true )
        apiService.fetchArtist(byName: name) { [weak self] (artists, error) in
            self?.updateLoadingStatus?(false)

            if error == nil {
                self?.items = artists!.items
                self?.updateCellViewModel()
                self?.reloadTableViewClosure?()
            } else {
                self?.showAlertClosure?("an error occurred, try again")
            }
        }
    }
    
    private func updateCellViewModel() {
        var vms = [ArtistListCellViewModel]()
        for item in items {
            let vm = createCellViewModel(item: item)
            vms.append(vm)
        }
        
        self.cellViewModels = vms
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> ArtistListCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createCellViewModel(item: Artist) -> ArtistListCellViewModel {
        var images = [String]()
        
        for image in item.images {
            images.append(image.url)
        }
        
        return ArtistListCellViewModel(name: item.name, images: images, followers: String(item.followers.total), popularity: String(item.popularity))
    }
    
    func userPressed( at indexPath: IndexPath ){
        self.selectedItem = self.items[indexPath.row]
    }
}

struct ArtistListCellViewModel {
    let name: String
    let images: [String]
    let followers: String
    let popularity: String
}

