import SwiftUI

struct AlbumListView: View {
    @StateObject var viewModel = AlbumListViewModel()
    var body: some View {
        NavigationStack {
            List(viewModel.albums) { album in
                Text(album.collectionName)
            }
            .listStyle(.plain)
            .searchable(text: $viewModel.searchTerm)
            .navigationTitle("Search")
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumListView()
    }
}
