//
//  AlbumViewModel.swift
//  SpotifyApp
//
//  Created by Jorge on 7/13/19.
//  Copyright © 2019 Jorge. All rights reserved.
//

import UIKit

class AlbumViewModel {
    let apiService: APIServiceProtocol
    var items: [Album] = [Album]()
    var selectedItem: Album?
    
    var reloadTableViewClosure: (()->())?
    var showAlertClosure: (( _ message: String )->())?
    var updateLoadingStatus: ((Bool)->())?
    
    var cellViewModels: [AlbumListCellViewModel] = [AlbumListCellViewModel]()
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    init(apiService: APIServiceProtocol ) {
        self.apiService = apiService
    }
    
    func getAlbumBy(artistId: String) {
        self.updateLoadingStatus?( true )
        apiService.fetchAlbums(byArtist: artistId) { [weak self] (albums, error) in
            self?.updateLoadingStatus?(false)
            
            if error == nil {
                self?.items = albums!
                self?.updateCellViewModel()
                self?.reloadTableViewClosure?()
            } else {
                self?.showAlertClosure?("an error occurred, try again")
            }
        }
    }
    
    private func updateCellViewModel() {
        var vms = [AlbumListCellViewModel]()
        for item in items {
            let vm = createCellViewModel(item: item)
            vms.append(vm)
        }
        
        self.cellViewModels = vms
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> AlbumListCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createCellViewModel(item: Album) -> AlbumListCellViewModel {
        var images = [String]()
        
        for image in item.images! {
            images.append(image.url)
        }
        var countries = "Countries: "
        for countryCode in item.availableMarkets! {
            let country = AppContext.shared().getCountryBy(code: countryCode);
            countries = countries + country.name + ", "
        }
        
        return AlbumListCellViewModel(name: item.name!, images: images, countries: countries)
    }
    
    func userPressed( at indexPath: IndexPath ){
        self.selectedItem = self.items[indexPath.row]
    }
}

struct AlbumListCellViewModel {
    let name: String
    let images: [String]
    let countries: String
}

