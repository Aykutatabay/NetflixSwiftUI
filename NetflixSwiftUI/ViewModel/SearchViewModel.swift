//
//  SearchViewModel.swift
//  NetflixSwiftUI
//
//  Created by Aykut ATABAY on 8.02.2023.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var discoverAll: [Title] = []
    @Published var text: String = ""
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getDiscoverMovies()
    }
    
    func getDiscoverMovies() {
        HomeViewDataService(url: APIUrl.getTopRatedMovies.apiUrl).$titles
            .combineLatest($text)
            .map({ titleArray, text -> [Title] in
                if !text.isEmpty {
                    return titleArray.filter { title -> Bool in
                        let textLowercased = text.lowercased()
                        let name = title.original_title ?? title.original_name ?? "Aykut"
                        return name.lowercased().contains(textLowercased)
                        
                    }
                }
                else {
                    return titleArray
                }
            })
            .sink {[weak self] titles in
                DispatchQueue.main.async {
                    self?.discoverAll = titles
                }
                
            }
            .store(in: &cancellables)
            
    }
}

