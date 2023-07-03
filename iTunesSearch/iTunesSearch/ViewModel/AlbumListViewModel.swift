import Foundation
import Combine

enum FetchState: Comparable {
    case good
    case isLoading
    case loadedAll
    case error(String)
}

final class AlbumListViewModel: ObservableObject {

    @Published var searchTerm = ""
    @Published var albums: [Album] = []
    @Published var state = FetchState.good
    var subscriptions = Set<AnyCancellable>()
    let limit = 20
    var page = 0
    init() {
        $searchTerm
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                self?.state = .good
                self?.albums = []
                self?.page = 0
                self?.fetchAlbums(for: term)
            }
            .store(in: &subscriptions)
    }
    
    func loadMore() {
        fetchAlbums(for: searchTerm)
    }
    func fetchAlbums(for searchTerm: String) {
        guard !searchTerm.isEmpty, state == .good else { return }
        state = .isLoading
        guard let url = URL(string: "https://itunes.apple.com/search?term=jack+johnson&entity=album&limit=5") else { return }
        Task {
            let (data, response) = try await URLSession.shared.data(from: url)
            print(String(data: data, encoding: .utf8))
        }
//        APIService.shared.fetchAlbums(searchTerm: searchTerm, page: page, limit: limit) {[weak self] result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let results):
//                    for album in results.results {
//                        self?.albums.append(album)
//                    }
//                    self?.page += 1
//                    self?.state = (self?.albums.count == self?.limit) ? .loadedAll : .good
//                case .failure(let error):
//                    self?.state = .error("Could not load: \(error.localizedDescription)")
//                }
//            }
//        }
    }
}


// https://itunes.apple.com/search?term=jack+johnson&entity=album&limit=5
// https://itunes.apple.com/search?term=jack+johnson&entity=song&limit=5
// https://itunes.apple.com/search?term=jack+johnson&entity=movie&limit=5
