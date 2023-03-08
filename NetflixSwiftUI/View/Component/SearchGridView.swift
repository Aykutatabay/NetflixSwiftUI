//
//  SearchGridView.swift
//  NetflixSwiftUI
//
//  Created by Aykut ATABAY on 5.02.2023.
//

import SwiftUI
import Kingfisher

struct SearchGridView: View {
    @EnvironmentObject var homeVm: HomeViewModel
    @ObservedObject var searchVM: SearchViewModel
    var columns: [GridItem] = [
        GridItem(.fixed((UIScreen.main.bounds.width / 3) - 5) ,spacing: 5, alignment: nil),
        GridItem(.fixed((UIScreen.main.bounds.width / 3) - 5) ,spacing: 5, alignment: nil),
        GridItem(.fixed((UIScreen.main.bounds.width / 3) - 5) ,spacing: 5, alignment: nil)
    ]
    var body: some View {
        
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(searchVM.discoverAll) { title in
                    
                    NavigationLink {
                        if let query1 = title.original_title ?? title.original_name {
                            TrailerView(title: title, trailerModel: TrailerViewModel(query: query1 + "Trailer"))
                        }
                    } label: {
                        ZStack(alignment: .topLeading) {
                            if let image = KFImage(URL(string: "https://image.tmdb.org/t/p/w500/\(title.poster_path ?? "")")) {
                                image
                                    .resizable()
                                    .frame(height: 200)
                                    .cornerRadius(5)
                                    
                            }
                            else {
                                Image("PF")
                                    .resizable()
                                    .frame(height: 200)
                                    .cornerRadius(5)
                            }

                            
                            Image("NL")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 15, height: 15)
                                .padding(.leading, 5)
                                .padding(.top, 14)
                                .opacity(title.id % 2 == 0 ? 1.0 : 0.0)
                        }
                    }
                }
            }
        }
    }
}

/*
 struct SearchGridView_Previews: PreviewProvider {
     static var previews: some View {
         SearchGridView()
     }
 }
 */

