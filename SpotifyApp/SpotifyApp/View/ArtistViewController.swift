//
//  ArtistViewController.swift
//  SpotifyApp
//
//  Created by Jorge on 7/13/19.
//  Copyright © 2019 Jorge. All rights reserved.
//

import UIKit
import JGProgressHUD
import AlamofireImage
import ImageSlideshow

class ArtistViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    let hud = JGProgressHUD(style: .dark)

    lazy var viewModel: ArtistViewModel = {
        return ArtistViewModel(apiService: APIService())
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initVM()
    }

    func initVM() {
        viewModel.showAlertClosure = { [weak self] message in
            DispatchQueue.main.async {
                self?.showAlert( message )
            }
        }
        
        viewModel.updateLoadingStatus = { [weak self] isLoading in
            DispatchQueue.main.async {
                if isLoading {
                    self?.hud.show(in: (self?.view)!)
                }else {
                    self?.hud.dismiss()
                }
            }
        }
        
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ArtistViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "artistCellIdentifier", for: indexPath) as? ArtistTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        
        let cellVM = viewModel.getCellViewModel( at: indexPath )
        cell.nameArtist.text = cellVM.name
        cell.followers.text = "Followers: " + cellVM.followers
        cell.popularity.text = "Popularity: " + cellVM.popularity
        
        var imagesSource:[AlamofireSource] = [AlamofireSource]()

        for image in cellVM.images {
            imagesSource.append(AlamofireSource(url: URL(string: image)!))
        }
        
        cell.imageArtist.setImageInputs(imagesSource)

        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        self.viewModel.userPressed(at: indexPath)
        return indexPath
    }
}

extension ArtistViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        viewModel.getArtistBy(name: textField.text!)
        return true
    }
}

extension ArtistViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? AlbumViewController,
            let artist = viewModel.selectedItem {
            vc.artist = artist
        }
    }
}
