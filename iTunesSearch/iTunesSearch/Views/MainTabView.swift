//
//  MainTabView.swift
//  iTunesSearch
//
//  Created by Vladimir on 09.03.2023.
//

import SwiftUI

struct MainTabView: View {
    @State var selection = 1
    var body: some View {
        TabView(selection: $selection) {
            AlbumListView().tabItem { Label("Albums", systemImage: "music.note") }.tag(1)
            MoviesListView().tabItem { Label("Movies", systemImage: "tv") }.tag(2)
        }

    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
