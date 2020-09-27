//
//  CollectionViewCell.swift
//  MusicApp
//
//  Created by BEREZIN Stanislav on 21.09.2020.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageCover: UIImageView?
    @IBOutlet weak var albumName: UILabel?
    @IBOutlet weak var artistName: UILabel?
    
    var image: UIImage?
    
    func configure(from track: Track) {
        self.albumName?.text = track.collectionName
        self.artistName?.text = track.artistName
        self.imageCover?.image = self.image
    }
}
