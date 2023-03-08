//
//  TrailerViewDataService.swift
//  NetflixSwiftUI
//
//  Created by Aykut ATABAY on 10.02.2023.
//

import Foundation
import Combine

class TrailerViewDataService {
    
    @Published var videoElement: VideoElement?
    
    var cancellables = Set<AnyCancellable>()
    
    init(urlString: String) {
        getVideoEelement(url: urlString)
    }
    
    func getVideoEelement(url: String) {
        guard let url = URL(string: url) else { return }
        NetworkingManager.downloadYoutube(url: url)
            .map({ array in
                return array[0]
            })
            .sink(receiveCompletion: { _ in
            }, receiveValue: { element in
                self.videoElement = element
            })
            .store(in: &cancellables)
    }
}
