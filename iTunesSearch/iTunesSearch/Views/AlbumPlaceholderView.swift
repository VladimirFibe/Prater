//
//  AlbumPlaceholderView.swift
//  iTunesSearch
//
//  Created by Vladimir on 09.03.2023.
//

import SwiftUI

struct AlbumPlaceholderView: View {
    @Binding var searchTerm: String
    let suggestions = ["rammstein", "cry", "maneskin"]
    var body: some View {
        VStack {
            ForEach(suggestions, id: \.self) { text in
                Button(action: {
                    searchTerm = text
                }) {
                    Text(text)
                }
            }
        }
    }
}

struct AlbumPlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumPlaceholderView(searchTerm: .constant(""))
    }
}
