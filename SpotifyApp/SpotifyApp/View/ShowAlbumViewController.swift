//
//  ShowAlbumViewController.swift
//  SpotifyApp
//
//  Created by Jorge on 7/13/19.
//  Copyright © 2019 Jorge. All rights reserved.
//

import UIKit
import ImageSlideshow
import AlamofireImage
import ImageSlideshow

class ShowAlbumViewController: UIViewController {
    @IBOutlet weak var imageAlbum: ImageSlideshow!
    var album:Album?


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var imagesSource:[AlamofireSource] = [AlamofireSource]()
        
        for image in album!.images! {
            imagesSource.append(AlamofireSource(url: URL(string: image.url)!))
        }
        
        self.imageAlbum.setImageInputs(imagesSource)
    }
    
    @IBAction func onOpenAlbum(_ sender: Any) {
        guard let url = URL(string: (self.album?.externalUrls!.spotify)!) else { return }
        UIApplication.shared.openURL(url)
    }
}
