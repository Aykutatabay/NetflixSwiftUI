//
//  SearchView.swift
//  NetflixSwiftUI
//
//  Created by Aykut ATABAY on 5.02.2023.
//

import SwiftUI

struct SearchView: View {
    @State var text: String = ""
    @EnvironmentObject var homeVM: HomeViewModel
    @StateObject var searchVM = SearchViewModel()
    var body: some View {
        NavigationView {
            VStack {
                Image("NLL")
                    .resizable()
                    .frame(width: 150, height: 80)
                    .padding(.top, -50)
                ZStack {
                    List {
                        ForEach(homeVM.discoverAll) { title in
                            NavigationLink {
                                if let query1 = title.original_title ?? title.original_name {
                                    TrailerView(title: title, trailerModel: TrailerViewModel(query: query1 + "Trailer"))
                                }
                            } label: {
                                MovieTableCell(title: title)
                            }
                        }
                        
                    }
                    .listStyle(.plain)
                    .padding(.horizontal, -30)
                    .padding(.bottom, -20)
                    .opacity(searchVM.text.isEmpty ? 1.0 : 0)
                    SearchGridView(searchVM: searchVM)
                        .opacity(searchVM.text.isEmpty ? 0 : 1.0)
                }
                //.padding(.top)
               // .padding(.top, -20)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        SearchBar(text: $searchVM.text)
                    }
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .preferredColorScheme(.dark)
    }
}
