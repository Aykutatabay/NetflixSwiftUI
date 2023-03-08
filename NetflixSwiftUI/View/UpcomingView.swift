//
//  UpcomingView.swift
//  NetflixSwiftUI
//
//  Created by Aykut ATABAY on 5.02.2023.
//

import SwiftUI

struct UpcomingView: View {
    @State var openTrailer: Bool = false
    @EnvironmentObject var homeVM: HomeViewModel
    var body: some View {
        NavigationView {
            List {
                ForEach(homeVM.upcomingMovies) { movie in
                    NavigationLink {
                        if let query1 = movie.original_title ?? movie.original_name {
                            TrailerView(title: movie, trailerModel: TrailerViewModel(query: query1 + "Trailer"))
                        }
                    } label: {
                        MovieTableCell(title: movie)
                    }
                }
                
            }
            .listStyle(.grouped)
            .padding(.horizontal, -30)
            .navigationTitle("Upcoming")
        }
    }
}

struct UpcomingView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingView()
            .preferredColorScheme(.dark)
    }
}
