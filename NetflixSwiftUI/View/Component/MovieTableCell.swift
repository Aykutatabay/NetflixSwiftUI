//
//  MovieTableCell.swift
//  NetflixSwiftUI
//
//  Created by Aykut ATABAY on 6.02.2023.
//

import SwiftUI
import Kingfisher

struct MovieTableCell: View {
    let title: Title
    let urlConstant: String = "https://image.tmdb.org/t/p/w500/"
    var body: some View {
        HStack {
            ZStack(alignment: .topLeading) {
                KFImage(URL(string: "\(urlConstant)\(title.poster_path ?? "")"))
                     .resizable()
                     .scaledToFill()
                     .frame(width: 55, height: 120)
                     .padding(.trailing, 20)
                     .padding(.leading, 10)
                     .cornerRadius(5)
                
                Image("NL")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 12, height: 12)
                    .padding(.leading, 2)
                    .padding(.top, 8)
                    .opacity(title.id % 2 == 0 ? 1.0 : 0.0)
            }

            
            Text(title.original_name ?? title.original_title ?? "Unknown Title")
                .font(.callout)
                .foregroundColor(.white)
                .lineLimit(1)
            
            Spacer()
            Spacer()
            Image(systemName: "play.circle")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.white)
                .padding(.trailing)
        }
        .padding(.leading, 10)
    }
}

/*
 struct MovieTableCell_Previews: PreviewProvider {
     static var previews: some View {
         MovieTableCell()
             .preferredColorScheme(.dark)
     }
 }
 */

