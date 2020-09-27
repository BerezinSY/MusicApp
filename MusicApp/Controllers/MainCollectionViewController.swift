//
//  MainCollectionViewController.swift
//  MusicApp
//
//  Created by BEREZIN Stanislav on 21.09.2020.
//

import UIKit

class MainCollectionViewController: UICollectionViewController {
    
    let numberOfItemsInRow: CGFloat = 2
    let sectionInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    var tracks: [Track] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        NetworkManager.shared.requestJSONData { (tracks) in
//            DispatchQueue.main.async {
//                self.tracks = tracks
//                self.collectionView.reloadData()
//            }
//        }
        
        NetworkManager.shared.requestJSONWithAlamofire { (tracks) in
            DispatchQueue.main.async {
                self.tracks = tracks
                self.collectionView.reloadData()
            }
        }
    }

    // MARK: UICollectionViewDataSource


    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        tracks.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let track = tracks[indexPath.item]
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "cell",
            for: indexPath) as! CollectionViewCell
        
        DispatchQueue.global(qos: .background).async {
            let imageData = NetworkManager.shared.getImage(fromTrack: track)
            
            DispatchQueue.main.async {
                cell.image = UIImage(data: imageData)
                cell.configure(from: track)
                cell.imageCover?.layer.cornerRadius = 10
            }
        }
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath) {
        
        let detailTableVC = storyboard?.instantiateViewController(
            identifier: "DetailTableViewController") as! DetailTableViewController
        
        detailTableVC.track = tracks[indexPath.item]
        navigationController?.pushViewController(detailTableVC, animated: true)
    }
    
    
}
extension MainCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingWidth = sectionInsets.left * (numberOfItemsInRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let itemWidth = availableWidth / numberOfItemsInRow
        return CGSize(width: itemWidth, height: itemWidth * 1.4)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        sectionInsets
    }

    func  collectionView(_ collectionView: UICollectionView,
                         layout collectionViewLayout: UICollectionViewLayout,
                         minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sectionInsets.left
    }
}
