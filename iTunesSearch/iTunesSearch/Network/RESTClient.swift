import UIKit

typealias Parameters = [String: Any]

final class RESTClient {
    static let shared = RESTClient()
    private init() {}
    
//    func request(_ route: RESTRoute) async throws -> (Data, Int?) {
//        guard let url = URL(string: route.baseUrl) else {throw RESTError.invalidURL}
//        var request = route.asURLRequest(baseUrl: url)
//        if route.auth {
//            try await refreshAccessToken()
//            request.addValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
//        }
//        let (data, response) = try await URLSession.shared.data(for: request)
//        let code = (response as? HTTPURLResponse)?.statusCode
//        return (data, code)
//    }
    
//    func request<Response: Decodable>(_ route: RESTRoute) async throws -> Response {
//        let (data, code) = try await request(route)
//        if code == 200 {
//            guard let result = try? JSONDecoder().decode(Response.self, from: data)
//            else { throw RESTError.invalidData }
//            return result
//        } else  {
//            if let code = code {
//                throw RESTError.code(code)
//            } else {
//                throw RESTError.serverError
//            }
//        }
//    }
    
    
    private enum Keys: String {
        case accessToken
        case refreshToken
        case clientId
    }
    
    var accessToken: String {
        get {
            UserDefaults.standard.string(forKey: Keys.accessToken.rawValue) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.accessToken.rawValue)
        }
    }
    
    var refreshToken: String {
        get {
            UserDefaults.standard.string(forKey: Keys.refreshToken.rawValue) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.refreshToken.rawValue)
        }
    }
    
    var clientId: String {
        get {
            UserDefaults.standard.string(forKey: Keys.clientId.rawValue) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.clientId.rawValue)
        }
    }
}
