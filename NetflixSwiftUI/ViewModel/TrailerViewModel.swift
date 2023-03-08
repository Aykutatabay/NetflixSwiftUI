//
//  TrailerViewModel.swift
//  NetflixSwiftUI
//
//  Created by Aykut ATABAY on 9.02.2023.
//

import Foundation
import Combine

struct Constants {
    static let API_KEY = "a31302215b7310216a39697e55145a16"
    static let baseURL = "https://api.themoviedb.org"
    static let YoutubeAPI_KEY = "AIzaSyBomX0uzR36EVt8aJBayY9qkwsxGAPkGWs"
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}




class TrailerViewModel: ObservableObject {
    @Published var videoElement: VideoElement?
    var cancellables = Set<AnyCancellable>()
    
    init(query: String) {
        getTrailer(with: (query + "trailer"))
    }
    
    func getTrailer(with query: String) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        let urlString = "https://youtube.googleapis.com/youtube/v3/search?q=\(query)&key=AIzaSyBomX0uzR36EVt8aJBayY9qkwsxGAPkGWs"
        TrailerViewDataService(urlString: urlString).$videoElement
            .sink(receiveValue: { videoElement in
                self.videoElement = videoElement
            })
            .store(in: &cancellables)
    }
}
