import Foundation

enum APIError: Error, CustomStringConvertible {
    case badURL
    case urlSession(URLError?)
    case badResponse(Int)
    case decoding(DecodingError?)
    case unknown
    
    var description: String {
        switch self {
        case .badURL: return "badURL"
        case .urlSession(let error): return "urlSession: \(error.debugDescription)"
        case .badResponse(let status): return "bad response: \(status)"
        case .decoding(_): return "decoding error"
        case .unknown: return "unknown"
        }
    }
    
    var localizedDescription: String {
        "something went wrong"
    }
}
