//
//  SerachBar.swift
//  NetflixSwiftUI
//
//  Created by Aykut ATABAY on 5.02.2023.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var body: some View {
        ZStack(alignment: .trailing) {
            HStack(spacing: 0) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding(.horizontal, 5)

                TextField("Search for a Movie or TV Show", text: $text)

            }
            .background(RoundedRectangle(cornerRadius: 15)
                .frame(height: 40)
                .foregroundColor(.gray.opacity(0.3)))
            
            if !text.isEmpty {
                Button {
                    self.text = ""
                } label: {
                    Circle()
                        .frame(width: 20, height: 20)
                        .overlay {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 10, height: 10)
                                .foregroundColor(.black)
                        }
                        .foregroundColor(.white.opacity(0.7))
                        .padding(.trailing, 5)
                }
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
            .preferredColorScheme(.dark)
    }
}
