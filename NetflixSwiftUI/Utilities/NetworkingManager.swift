//
//  NetworkingManager.swift
//  NetflixSwiftUI
//
//  Created by Aykut ATABAY on 7.02.2023.
//

import Foundation
import Combine

class youtubeApi {
   let youtubeApiKey = "AIzaSyD2-GcwSaHsV1J910hZoGO29EgrgjxN0E8"
    
    let url = "https://youtube.googleapis.com/youtube/v3/search?q=Aykut&key=AIzaSyD2-GcwSaHsV1J910hZoGO29EgrgjxN0E8"
}

class NetworkingManager {
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ try handleUrlResponse(output: $0)})
            .retry(3)
            .eraseToAnyPublisher()

        
    }
    
    static func downloadYoutube(url: URL) -> AnyPublisher<[VideoElement], Error> {
        return Future<[VideoElement], Error> { promise in
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, rsponse, error in
                guard let data = data else { return }
                do {
                    let returnedData = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                    let dataArray = returnedData.items
                    promise(.success(dataArray))
                } catch let error {
                    promise(.failure(error))
                }
            }
            task.resume()
        }.eraseToAnyPublisher()

    }
    
    static func handleUrlResponse(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200,
              response.statusCode < 300  else { throw URLError(.badURL) }
        
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Publishers.Decode<AnyPublisher<Data, Error>, TrendingTitlesResponse, JSONDecoder>.Failure>) {
        switch completion {
        case .finished:
            print("Succesfully decoded")
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    static func handleCompletionYoutube(completion: Subscribers.Completion<Publishers.Decode<AnyPublisher<Data, Error>, VideoElement, JSONDecoder>.Failure>) {
        switch completion {
        case .finished:
            print("Succesfully decoded youtube")
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}

