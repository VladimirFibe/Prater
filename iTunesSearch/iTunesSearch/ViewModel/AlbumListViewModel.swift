import Foundation
import Combine

final class AlbumListViewModel: ObservableObject {
    @Published var searchTerm = ""
    @Published var albums: [Album] = []
    var subscriptions = Set<AnyCancellable>()
    let limit = 20
    init() {
        $searchTerm
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
            self?.fetchAlbums(for: term)
        }
        .store(in: &subscriptions)
    }
    func fetchAlbums(for searchTerm: String) {
        guard let url = URL(string: "https://itunes.apple.com/search?term=\(searchTerm)&entity=album&limit=\(limit)") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                print(error.localizedDescription)
            } else if let data {
                do {
                   let result = try JSONDecoder().decode(AlbumResult.self, from: data)
                    DispatchQueue.main.async {
                        self.albums = result.results
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}


// https://itunes.apple.com/search?term=jack+johnson&entity=album&limit=5
// https://itunes.apple.com/search?term=jack+johnson&entity=song&limit=5
// https://itunes.apple.com/search?term=jack+johnson&entity=movie&limit=5
