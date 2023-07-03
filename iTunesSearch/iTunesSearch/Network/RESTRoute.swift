import Foundation

enum RESTRoute {
    case search(String)
    private var method: String {
        switch self {
        case .search: return "GET"
        }
    }
    
    private var baseUrl: String {
        
    }
}
