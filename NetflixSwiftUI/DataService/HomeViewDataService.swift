//
//  HomeViewDataService.swift
//  NetflixSwiftUI
//
//  Created by Aykut ATABAY on 7.02.2023.
//

import Foundation
import Combine



class HomeViewDataService {
    
    @Published var titles: [Title] = []
    
    /*
     @Published var upcomingMovies: [Title] = []
     @Published var popularMovies: [Title] = []
     @Published var trendingTVs: [Title] = []
     @Published var topRatedMovies: [Title] = []
     @Published var discoverAll: [Title] = []
     */

    init(url: String) {
        getTrendingMovies(url: url)
        
        /*
         getUpcomingMovies()
         getPopularMovies()
         getTrendingTvs()
         getTopRatedMovies()
         getDiscoverMovies()
         */

    }
    
    var cancellables = Set<AnyCancellable>()
    
    func getTrendingMovies(url: String) {
        guard let url = URL(string: url) else { return }
        
        NetworkingManager.download(url: url)
            .decode(type: TrendingTitlesResponse.self, decoder: JSONDecoder())
            .map({ response in
                return response.results
            })
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { titleArray in
                self.titles = titleArray
            })
            .store(in: &cancellables)
    }
    /*
     func getUpcomingMovies() {
         guard let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=a31302215b7310216a39697e55145a16&language=en-US&page=1") else { return }
         NetworkingManager.download(url: url)
             .decode(type: TrendingTitlesResponse.self, decoder: JSONDecoder())
             .map({ response in
                 return response.results
             })
             .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { titleArray in
                 self.upcomingMovies = titleArray
             })
             .store(in: &cancellables)
     }
     
     func getPopularMovies() {
         guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=a31302215b7310216a39697e55145a16&language=en-US&page=1") else { return }
         NetworkingManager.download(url: url)
             .decode(type: TrendingTitlesResponse.self, decoder: JSONDecoder())
             .map({ response in
                 return response.results
             })
             .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { titleArray in
                 self.popularMovies = titleArray

             })
             .store(in: &cancellables)
     }
     
     func getTrendingTvs() {
         guard let url = URL(string: "https://api.themoviedb.org/3/trending/tv/day?api_key=a31302215b7310216a39697e55145a16" ) else { return }
         NetworkingManager.download(url: url)
             .decode(type: TrendingTitlesResponse.self, decoder: JSONDecoder())
             .map({ response in
                 return response.results
             })
             .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { titleArray in
                 self.trendingTVs = titleArray
             })
             .store(in: &cancellables)
     }
     
     func getTopRatedMovies() {
         guard let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=a31302215b7310216a39697e55145a16&language=en-US&page=1" ) else { return }
         NetworkingManager.download(url: url)
             .decode(type: TrendingTitlesResponse.self, decoder: JSONDecoder())
             .map({ response in
                 return response.results
             })
             .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { titleArray in
                 self.topRatedMovies = titleArray
             })
             .store(in: &cancellables)
     }
     func getDiscoverMovies() {
         guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=a31302215b7310216a39697e55145a16&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate" ) else { return }
         NetworkingManager.download(url: url)
             .decode(type: TrendingTitlesResponse.self, decoder: JSONDecoder())
             .map({ response in
                 return response.results
             })
             .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { titleArray in
                 self.discoverAll = titleArray
             })
             .store(in: &cancellables)
     }
     */
}



