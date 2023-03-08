//
//  ContentView.swift
//  NetflixSwiftUI
//
//  Created by Aykut ATABAY on 5.02.2023.
//

import SwiftUI

enum NavigationTitle {
    case comingSoon
    case search
    case download
    
    var navTitle: String  {
        switch self {
        case .search :
            return "Search"
        case .comingSoon :
            return "Upcoming"
        case .download :
            return "Download"
        }
    }
    
}

struct ContentView: View {
    @State private var selectedIndex: Int = 0
    @State var searchText: String = ""
    @State var navTtitle: String = ""
    var body: some View {
        TabView(selection: $selectedIndex) {
            HomeView()
                .tabItem {
                    VStack {
                        Image(systemName: "house")
                        Text("Home")
                    }
                }
                .onTapGesture {
                    self.selectedIndex = 0
                    
                }
                .tag(0)
            
            UpcomingView()
                .tabItem {
                    Image(systemName: "play.circle")
                    Text("Coming Soon")
                }
                .onTapGesture {
                    self.selectedIndex = 1
                    self.navTtitle = NavigationTitle.comingSoon.navTitle
                }
                .tag(1)

            SearchView()
                .padding(.vertical)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Top Search")
                }
                .onTapGesture {
                    self.selectedIndex = 2
                    self.navTtitle = NavigationTitle.search.navTitle
                }
                .tag(2)

            
            DownloadView()
                .tabItem {
                    Image(systemName: "arrow.down.to.line")
                    Text("Downloads")
                }
                .onTapGesture {
                    self.selectedIndex = 3
                    self.navTtitle = NavigationTitle.download.navTitle
                }
                .tag(3)
        }
        .accentColor(Color.red)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
