//
//  HorizontalScrollView.swift
//  NetflixSwiftUI
//
//  Created by Aykut ATABAY on 5.02.2023.
//

import SwiftUI
import Kingfisher

struct HorizontalScrollView: View {
    @EnvironmentObject var homeVM: HomeViewModel
    let titles: [Title]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            HStack {
                ForEach(titles) { title in
                    NavigationLink {
                        if let query1 = title.original_title ?? title.original_name {
                            TrailerView(title: title, trailerModel: TrailerViewModel(query: query1 + "Trailer"))
                        }
                    } label: {
                        ZStack (alignment: .topLeading) {
                            KFImage(URL(string: "https://image.tmdb.org/t/p/w500/\(title.poster_path ?? "")"))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 140, height: 200)
                                .cornerRadius(5)
                                .contextMenu {
                                    Button {
                                        homeVM.addItems(title: title)
                                    } label: {
                                        HStack {
                                            Text("Download")
                                            Image(systemName: "arrow.down.to.line")
                                        }
                                        .padding(.horizontal)
                                    }

                                }
                            
                            Image("NL")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 12, height: 18)
                                .padding(.leading, 5)
                                .padding(.top, 8)
                                .opacity(title.id % 2 == 0 ? 1.0 : 0)
                        }
                    }
                }
            }
        }
    }
}

/*
 struct HorizontalScrollView_Previews: PreviewProvider {
     static var previews: some View {
         HorizontalScrollView(trendingTitles: )
     }
 }
 */

