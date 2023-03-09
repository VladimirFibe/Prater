import SwiftUI

struct AlbumListView: View {
    @StateObject var viewModel = AlbumListViewModel()
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
            ForEach(viewModel.albums) { album in
                Text(album.collectionName)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumListView()
    }
}
