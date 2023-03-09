import Foundation
import Combine

final class SongListViewModel: ObservableObject {
    
    @Published var searchTerm = ""
    @Published var songs: [Song] = []
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
                self?.songs = []
                self?.page = 0
                self?.fetchSongs(for: term)
            }
            .store(in: &subscriptions)
    }
    
    func loadMore() {
        fetchSongs(for: searchTerm)
    }
    func fetchSongs(for searchTerm: String) {
        guard !searchTerm.isEmpty, state == .good else { return }
        state = .isLoading
        APIService.shared.fetchSongs(searchTerm: searchTerm, page: page, limit: limit) {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    for song in results.results {
                        self?.songs.append(song)
                    }
                    self?.page += 1
                    self?.state = (self?.songs.count == self?.limit) ? .loadedAll : .good
                case .failure(let error):
                    self?.state = .error("Could not load: \(error.localizedDescription)")
                }
            }
        }
    }
}
