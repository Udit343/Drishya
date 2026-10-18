//  YoutubeSearchResponse.swift
//  Drishya
//  Created by UDIT PANDEY on 07/10/26.

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [ItemProperties]?
}

struct ItemProperties: Codable {
    let id: IdProperties?
}

struct IdProperties: Codable {
    let videoId: String?
}
