//
//  DownloadView.swift
//  NetflixSwiftUI
//
//  Created by Aykut ATABAY on 6.02.2023.
//

import SwiftUI

struct DownloadView: View {
    @EnvironmentObject var homeVM: HomeViewModel
    @State var showAlert: Bool = false
    @State var showInfo: Bool = false
    var body: some View {
        NavigationView {
            List {
                ForEach(homeVM.downloadedTitles) { title in
                    NavigationLink {
                        if let query1 = title.original_title ?? title.original_name {
                            TrailerView(title: title, trailerModel: TrailerViewModel(query: query1 + "Trailer"))
                        }
                    } label: {
                        MovieTableCell(title: title)
                    }
                    .swipeActions(content: {
                        Button("Delete") {
                            homeVM.movie = title
                            print(title.original_name ?? title.original_title)
                            let movie = title
                            showAlert = true
                        }
                        .tint(.red)
                        
                    })
                }
                .alert( isPresented: $showInfo, content: {
                    getInfo(title: homeVM.movie!)
                })
            }
            .alert( isPresented: $showAlert, content: {
                getAlert(title: homeVM.movie!)
            })
            .listStyle(.automatic)
            .padding(.horizontal, -30)
            .navigationTitle("Downloads")
        }
    }
    
    func getAlert(title: Title) -> Alert {
        let titleName = title.original_name ?? title.original_title ?? "Unknown"
        print(titleName,"Aykuttooo")
        return Alert(title: Text("Do you want to delete this content ?"),message: Text("\(titleName.uppercased()) will be removed permenantly"), primaryButton: .cancel(), secondaryButton: .destructive(Text("Delete"), action: {
            homeVM.deleteSavedTitle(title: title)
            self.showInfo.toggle()
        }))
    }
    func getInfo(title: Title) -> Alert {
        let titleName = title.original_name ?? title.original_title ?? "Unknown"
        return Alert(title: Text("\(titleName.uppercased()) successfully deleted"), message: nil, dismissButton: .default(Text("OK"), action: {
        
        }))
    }
}

struct DownloadView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadView()
    }
}
