//
//  HomeViewModel.swift
//  NetflixSwiftUI
//
//  Created by Aykut ATABAY on 7.02.2023.
//

import Foundation
import Combine

enum APIUrl {
    case getTrendingMovies
    case getUpcomingMovies
    case getPopularMovies
    case getTrendingTvs
    case getTopRatedMovies
    case getDiscoverMovies
    
    var apiUrl: String {
        switch self {
        case .getTrendingMovies:
            return "https://api.themoviedb.org/3/trending/movie/day?api_key=a31302215b7310216a39697e55145a16"
        case .getTrendingTvs:
            return "https://api.themoviedb.org/3/trending/tv/day?api_key=a31302215b7310216a39697e55145a16"
        case .getPopularMovies:
            return "https://api.themoviedb.org/3/movie/popular?api_key=a31302215b7310216a39697e55145a16&language=en-US&page=1"
        case .getUpcomingMovies:
            return "https://api.themoviedb.org/3/movie/upcoming?api_key=a31302215b7310216a39697e55145a16&language=en-US&page=1"
        case .getTopRatedMovies:
            return "https://api.themoviedb.org/3/movie/top_rated?api_key=a31302215b7310216a39697e55145a16&language=en-US&page=1"
        case .getDiscoverMovies:
            return "https://api.themoviedb.org/3/discover/movie?api_key=a31302215b7310216a39697e55145a16&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate"
        }
    }
}


class HomeViewModel: ObservableObject {
    
    @Published var trendingMovies: [Title] = []
    @Published var upcomingMovies: [Title] = []
    @Published var popularMovies: [Title] = []
    @Published var trendingTVs: [Title] = []
    @Published var topRatedMovies: [Title] = []
    @Published var discoverAll: [Title] = []
    @Published var allTitles: [Title] = []
    @Published var downloadedTitles: [Title] = []
    var movie: Title? = nil
    
    var cancellables = Set<AnyCancellable>()
    var downloadModel = DownloadViewModel()
    
    init() {
        getTrendingMovies()
        getTrendingTv()
        getUpcomingMovies()
        getPopularMovies()
        getTopRatedMovies()
        getDiscoverMovies1()
        getDownloadedTitle()
        downloadModel.getTitles()
    }
    
    func getTrendingMovies() {
        HomeViewDataService(url: APIUrl.getTrendingMovies.apiUrl).$titles
            .sink {[weak self] titles in
                DispatchQueue.main.async {
                    self?.trendingMovies.append(contentsOf: titles)
                    self?.allTitles.append(contentsOf: titles)
                }
            }
            .store(in: &cancellables)
    }
    func getTrendingTv() {
        HomeViewDataService(url: APIUrl.getTrendingTvs.apiUrl).$titles
            .sink {[weak self] titles in
                DispatchQueue.main.async {
                    self?.trendingTVs = titles
                    self?.allTitles.append(contentsOf: titles)
                    
                }
            }
            .store(in: &cancellables)
    }
    func getUpcomingMovies() {
        HomeViewDataService(url: APIUrl.getUpcomingMovies.apiUrl).$titles
            .sink {[weak self] titles in
                DispatchQueue.main.async {
                    self?.upcomingMovies = titles
                    self?.allTitles.append(contentsOf: titles)
                    
                }
            }
            .store(in: &cancellables)
    }
    func getPopularMovies() {
        HomeViewDataService(url: APIUrl.getPopularMovies.apiUrl).$titles
            .sink {[weak self] titles in
                DispatchQueue.main.async {
                    self?.popularMovies = titles
                    self?.allTitles.append(contentsOf: titles)
                    
                }
            }
            .store(in: &cancellables)
    }
    
    func getTopRatedMovies() {
        HomeViewDataService(url: APIUrl.getTopRatedMovies.apiUrl).$titles
            .sink {[weak self] titles in
                DispatchQueue.main.async {
                    self?.topRatedMovies = titles
                    self?.allTitles.append(contentsOf: titles)
                }
            }
            .store(in: &cancellables)
    }
    
    func getDiscoverMovies1() {
        HomeViewDataService(url: APIUrl.getDiscoverMovies.apiUrl).$titles
            .sink {[weak self] titles in
                DispatchQueue.main.async {
                    self?.discoverAll = titles
                    self?.allTitles.append(contentsOf: titles)
                }
            }
            .store(in: &cancellables)
    }
    
    
    func addItems(title: Title) {
        downloadModel.addItems(title: title)
   }
    
     func getDownloadedTitle() {
         $allTitles
             .combineLatest(downloadModel.$savedTitles)
             .map(compactMap)
             .sink(receiveValue: {[weak self] titles in
                 self?.downloadedTitles = titles
             })
             .store(in: &cancellables)
         
     }
     
     private func compactMap(titles: [Title], savedItems: [TitleItem]) -> [Title] {
         savedItems
             .compactMap { titleItem -> Title? in
                 let entity = titles.first(where: { $0.id == titleItem.id})
                 return entity
             }
     }
    
    func deleteSavedTitle(title: Title) {
        downloadModel.removeTitle(title: title)
    }
}
