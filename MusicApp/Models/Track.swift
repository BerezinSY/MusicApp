//
//  Track.swift
//  MusicApp
//
//  Created by BEREZIN Stanislav on 23.09.2020.
//

import Foundation

struct Track: Codable {
    let artistName: String?
    let collectionName: String?
    let trackName: String?
    let artworkUrl30: URL?
    let artworkUrl60: URL?
    let artworkUrl100: URL?
    let trackCount: Int?
    let primaryGenreName: String?
    let releaseDate: String?
    
    var track: String {
        guard let trackCount = trackCount else { return "" }
        guard let trackName = trackName else { return "" }
        
        return "\(trackCount) - \(trackName)"
    }
    
    var genreYear: String {
        
        guard let genre = primaryGenreName else { return "" }
        return "\(genre) • \(year)"
    }
    
    var year: String {
        guard let firstSymbol = releaseDate?.firstIndex(of: "-") else { return "" }
        guard let yearString = releaseDate?[..<firstSymbol] else { return "" }
        return "\(yearString)"
    }
}
