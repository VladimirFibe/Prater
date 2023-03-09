//
//  MoviesListView.swift
//  iTunesSearch
//
//  Created by Vladimir on 09.03.2023.
//

import SwiftUI

struct MoviesListView: View {
    @StateObject var viewModel = MovieListViewModel()
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.searchTerm.isEmpty {
                    AlbumPlaceholderView(searchTerm: $viewModel.searchTerm)
                } else {
                    content
                }
            }
            .searchable(text: $viewModel.searchTerm)
            .navigationTitle("Search")
        }

    }
    var content: some View {
        List {
            ForEach(viewModel.movies) { movie in
                Text(movie.trackName)
            }
            switch viewModel.state {
                
            case .good: Color.clear.onAppear {
                viewModel.loadMore()
            }
            case .isLoading:
                ProgressView()
            case .loadedAll:
                EmptyView()
            case .error(let text):
                Text(text)
            }
            
        }
        .listStyle(.plain)
    }
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView()
    }
}
