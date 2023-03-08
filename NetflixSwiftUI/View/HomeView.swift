//
//  HomeView.swift
//  NetflixSwiftUI
//
//  Created by Aykut ATABAY on 5.02.2023.
//

import SwiftUI
import Kingfisher

enum SectionNameNetflix: CaseIterable {
    case trendingMovies
    case trendingTv
    case popular
    case upcoming
    case topRated
    
    var title: String {
        switch self {
        case .trendingTv:
            return "Trending TV"
        case .upcoming:
            return "Upcoming Movies"
        case .popular:
            return "Popular"
        case .trendingMovies:
            return "Trending Movies"
        case .topRated:
            return "Top Rated"
        }
    }
        
}

struct HomeView: View {

    @EnvironmentObject var homeVM: HomeViewModel

    
    let titles: [String] = [
        "Trending Movies",
        "Trending TV",
        "Popular",
        "Upcoming Movies",
        "Top Rated"
    ]
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: true){
                ZStack {
                    KFImage(URL(string: "https://image.tmdb.org/t/p/w500/\(homeVM.discoverAll.randomElement()?.poster_path ?? "")"))
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width, height: 600)
                        .cornerRadius(5)
                     //   .background(LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .topLeading, endPoint: .bottom))
                        .shadow(color: .gray.opacity(0.2), radius: 20, x: 0, y: 10)
                        .opacity(0.5)
                    
                    
                    Rectangle()
                        .fill(LinearGradient(gradient: Gradient(colors: [.black,.black.opacity(0.9),.black.opacity(0.7),.black.opacity(0.5),.clear,.clear,.clear,.clear,.clear,.clear, .black.opacity(0.5), .black.opacity(0.8), .black]), startPoint: .top, endPoint: .bottom))
                        .frame(width: UIScreen.main.bounds.width, height: 600)
                        .cornerRadius(5)
                        .opacity(0.9)
                    
                    
                    VStack {
                        Spacer()
                        HStack(spacing: 60) {
                            Button {
                                
                            } label: {
                                RoundedRectangle(cornerRadius: 4)
                                    .frame(width: 120, height: 30)
                                    .foregroundColor(.white)
                                    .overlay {
                                        HStack {
                                            Image(systemName: "play.fill")
                                                .foregroundColor(.black)
                                            Text("Play")
                                                .font(.body)
                                            .foregroundColor(.black)
                                        }
                                    }

                            }
                            
                            Button {
                                
                            } label: {
                                RoundedRectangle(cornerRadius: 4)
                                    .frame(width: 120, height: 30)
                                    .foregroundColor(.gray.opacity(0.3))
                                    .overlay {
                                        HStack(spacing: 5) {
                                            Image(systemName: "plus")
                                                .foregroundColor(.white)
                                            Text("My List")
                                                .font(.body)
                                            .foregroundColor(.white)
                                        }
                                    }

                            }
                        }
                        .padding(.bottom, 50)
                    }
                    
                }
                .padding(.top, -20)
                
                ForEach(SectionNameNetflix.allCases, id: \.self) { title in
                    VStack(alignment: .leading, spacing: 5) {
                        Text(title.title.uppercased())
                            .font(.headline)
                            .bold()
                            .padding(.leading, 5)
                            .opacity(0.8)
                        switch title {
                            
                        case .topRated:
                            HorizontalScrollView(titles: homeVM.topRatedMovies)
                                .frame( height: 200)
                        case .popular:
                            HorizontalScrollView(titles: homeVM.popularMovies)
                                .frame( height: 200)
                        case .upcoming:
                            HorizontalScrollView(titles: homeVM.upcomingMovies)
                                .frame( height: 200)
                        case .trendingTv:
                            HorizontalScrollView(titles: homeVM.trendingTVs)
                                .frame( height: 200)
                        case .trendingMovies:
                            HorizontalScrollView(titles: homeVM.trendingMovies)
                                .frame( height: 200)
                        }
                        

                    }.padding(.horizontal, 5)
                        .padding(.top, 20)
                }
                .padding(.top, -10)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image("NL")
                        .resizable()
                        .frame(width: 20, height: 35)
                }
                
                ToolbarItem(placement: .principal) {
                    Image("NLL")
                        .resizable()
                        .frame(width: 160, height: 80)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Image(systemName: "play.rectangle")
                        Image(systemName: "person")
                        
                    }
                }
        }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
