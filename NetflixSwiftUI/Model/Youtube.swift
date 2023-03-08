//
//  Youtube.swift
//  NetflixSwiftUI
//
//  Created by Aykut ATABAY on 9.02.2023.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable  {
    let kind: String
    let videoId: String
}




struct TitleTrailerView {
    let title: String
    let youtubeView: VideoElement
    let titleOverview: String
    
    init(title: String, youtubeView: VideoElement, titleOverview: String) {
        self.title = title
        self.youtubeView = youtubeView
        self.titleOverview = titleOverview
    }
}
