//
//  NetworkManager.swift
//  MusicApp
//
//  Created by BEREZIN Stanislav on 23.09.2020.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func requestJSONData(completion: @escaping ([Track]) -> ()) {
        let urlString = "https://itunes.apple.com/search?term=Scorpions&country=RU"
        guard let url = URL(string: urlString) else { return }
        let session = URLSession.shared
        session.dataTask(with: url) { (data, _, error) in
            
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            let jsonDecoder = JSONDecoder()
            
            do {
                let responseData = try jsonDecoder.decode(ResponseData.self, from: data)
                completion(responseData.results)
            } catch let error as NSError {
                print(error)
            }
        }.resume()
    }
    
    func requestJSONWithAlamofire(completion: @escaping ([Track]) -> ()) {
        let urlString = "https://itunes.apple.com/search?term=Scorpions&country=RU&limit=20"
        guard let url = URL(string: urlString) else { return }
        AF.request(url).validate().responseJSON { (dataResponse) in
            switch dataResponse.result {
            
            case .success(let value):
                
                guard let json = value as? [String: Any] else { return }
                guard let results = json["results"] as? [[String: Any]] else { return }
                var tracks: [Track] = []
                for result in results {
                    let track = Track(
                        artistName: result["artistName"] as? String,
                        collectionName: result["collectionName"] as? String,
                        trackName: result["trackName"] as? String,
                        artworkUrl30: result["artworkUrl30"] as? URL,
                        artworkUrl60: result["artworkUrl60"] as? URL,
                        artworkUrl100: result["artworkUrl100"] as? URL,
                        trackCount: result["trackCount"] as? Int,
                        primaryGenreName: result["primaryGenreName"] as? String,
                        releaseDate: result["releaseDate"] as? String
                    )
                    
                    tracks.append(track)
                    print(tracks)
                    completion(tracks)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getImage(fromTrack track: Track) -> Data {
        guard let imageURL = track.artworkUrl100 else { return Data() }
        guard let imageData = try? Data(contentsOf: imageURL) else { return Data() }
        return imageData
    }
}

