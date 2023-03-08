//
//  TrailerView.swift
//  NetflixSwiftUI
//
//  Created by Aykut ATABAY on 6.02.2023.
//

import SwiftUI
import SDWebImage
import WebKit
import Kingfisher
struct TrailerView: View {
    
    let title: Title
    let trailerModel: TrailerViewModel
    let constantUrl: URL = URL(string: "https://www.youtube.com/watch?v=t0qdFLHZ-Kc" )!

    
    var body: some View {
        ScrollView {
            
            Text(title.original_name ?? title.original_title ?? "Unknown Name")
                .font(.title)
                .bold()
            
            ZStack {
                KFImage(URL(string: "https://image.tmdb.org/t/p/w500/\(title.poster_path ?? "")"))
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
            }
            .padding(.top, -20)
            

            Divider()
                .foregroundColor(.white)
            
            Text("Trailer")
                .font(.title2)
                .bold()
                .padding(.bottom)
            
            if let videoId = trailerModel.videoElement?.id.videoId,
               let url = URL(string: "https://www.youtube.com/watch?v=\(videoId)")
                
            {
                WebView(url: url )
                     .frame(width: UIScreen.main.bounds.width, height: 350)
                     .clipShape(RoundedRectangle(cornerRadius: 10))
                
            } else {
                WebView(url: constantUrl)
                     .frame(width: UIScreen.main.bounds.width, height: 350)
                     .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            Divider()
            
            Text("Overview")
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.bottom)
                .padding(.vertical)
                .foregroundColor(.white)
            
            Text(title.overview ?? "Unknown Overview")
                .font(.body)
                .padding(.horizontal, 15)
        }
    }
}

/*
 struct TrailerView_Previews: PreviewProvider {
     static var previews: some View {
         TrailerView()
             .preferredColorScheme(.dark)
     }
 }
 */
