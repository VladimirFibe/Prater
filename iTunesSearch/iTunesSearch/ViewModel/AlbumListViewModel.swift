import Foundation
import Combine

final class AlbumListViewModel: ObservableObject {
    enum State: Comparable {
        case good
        case isLoading
        case loadedAll
        case error(String)
    }
    @Published var searchTerm = ""
    @Published var albums: [Album] = []
    @Published var state = State.good
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
        let offset = page * limit
        guard let url = URL(string: "https://itunes.apple.com/search?term=\(searchTerm)&entity=album&limit=\(limit)&offset=\(offset)") else { return }
        state = .isLoading
        URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            guard let self else { return }
            if let error {
                DispatchQueue.main.async {
                    self.state = .error(error.localizedDescription)
                }
            } else if let data {
                do {
                    let result = try JSONDecoder().decode(AlbumResult.self, from: data)
                    DispatchQueue.main.async {
                        for album in result.results {
                            self.albums.append(album)
                        }
                        self.page += 1
                        print("result: ", result.resultCount, self.limit)
                        self.state = (self.albums.count == self.limit) ? .loadedAll : .good
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.state = .error(error.localizedDescription)
                    }
                }
            }
            
        }.resume()
    }
    
    func createURL(for searchTerm: String) -> URL? {
        let baseURL = "itunes.apple.com/search"
        let offset = page * limit
        let querItems = [
        URLQueryItem(name: "term", value: searchTerm),
        URLQueryItem(name: "entity", value: "album"),
        URLQueryItem(name: "limit", value: String(limit)),
        URLQueryItem(name: "offset", value: String(offset))
        ]
        var components = URLComponents(string: baseURL)
        components?.queryItems = querItems
        return components?.url
    }
}


// https://itunes.apple.com/search?term=jack+johnson&entity=album&limit=5
// https://itunes.apple.com/search?term=jack+johnson&entity=song&limit=5
// https://itunes.apple.com/search?term=jack+johnson&entity=movie&limit=5
