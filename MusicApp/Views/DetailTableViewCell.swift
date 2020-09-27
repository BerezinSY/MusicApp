//
//  DetailTableViewCell.swift
//  MusicApp
//
//  Created by BEREZIN Stanislav on 26.09.2020.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var artCover: UIImageView!
    @IBOutlet weak var album: UILabel!
    @IBOutlet weak var artist: UILabel!
    @IBOutlet weak var genre: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        artCover.layer.cornerRadius = 10
    }
    
    func configureCell(withData track: Track) {
        
        DispatchQueue.global(qos: .background).async {
            guard let imageURL = track.artworkUrl100 else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            let image = UIImage(data: imageData)
            
            DispatchQueue.main.async {
                self.artCover.image = image
                self.artist.text = track.artistName
                self.album.text = track.collectionName
                self.genre.text = track.genreYear
            }
        }
    }
}
