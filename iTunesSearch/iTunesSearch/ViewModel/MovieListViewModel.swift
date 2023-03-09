import Foundation
import Combine

final class MovieListViewModel: ObservableObject {

    @Published var searchTerm = ""
    @Published var movies: [Movie] = []
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
                self?.movies = []
                self?.page = 0
                self?.fetchMovies(for: term)
            }
            .store(in: &subscriptions)
    }
    
    func loadMore() {
        fetchMovies(for: searchTerm)
    }
    func fetchMovies(for searchTerm: String) {
        guard !searchTerm.isEmpty, state == .good else { return }
        state = .isLoading
        APIService.shared.fetchMovies(searchTerm: searchTerm, page: page, limit: limit) {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    for movie in results.results {
                        self?.movies.append(movie)
                    }
                    self?.page += 1
                    self?.state = (self?.movies.count == self?.limit) ? .loadedAll : .good
                case .failure(let error):
                    self?.state = .error("Could not load: \(error.localizedDescription)")
                }
            }
        }
    }
}
