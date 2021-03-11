//
//  ArtistTableViewCell.swift
//  SpotifyApp
//
//  Created by Jorge on 7/13/19.
//  Copyright © 2019 Jorge. All rights reserved.
//

import UIKit
import ImageSlideshow

class ArtistTableViewCell: UITableViewCell {
    @IBOutlet weak var nameArtist: UILabel!
    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var popularity: UILabel!
    @IBOutlet weak var imageArtist: ImageSlideshow!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
