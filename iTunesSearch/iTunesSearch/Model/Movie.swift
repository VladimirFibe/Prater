import Foundation

// MARK: - MovieResult
struct MovieResult: Codable {
    let resultCount: Int
    let results: [Movie]
}

// MARK: - Result
struct Movie: Codable, Identifiable {
    let id: Int
    let artistName, trackName, trackCensoredName: String
//    let wrapperType, kind: String
//    let artistID: Int
//    let artistViewURL, trackViewURL: String
//    let previewURL: String
//    let artworkUrl30, artworkUrl60, artworkUrl100: String
//    let collectionPrice, trackPrice, trackRentalPrice, collectionHDPrice: Double
//    let trackHDPrice, trackHDRentalPrice: Double
//    let releaseDate: Date
//    let collectionExplicitness, trackExplicitness: String
//    let trackTimeMillis: Int
//    let country, currency, primaryGenreName, contentAdvisoryRating: String
//    let longDescription: String

    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case artistName, trackName, trackCensoredName
//        case wrapperType, kind
//        case artistID = "artistId"
//        case artistViewURL = "artistViewUrl"
//        case trackViewURL = "trackViewUrl"
//        case previewURL = "previewUrl"
//        case artworkUrl30, artworkUrl60, artworkUrl100, collectionPrice, trackPrice, trackRentalPrice
//        case collectionHDPrice = "collectionHdPrice"
//        case trackHDPrice = "trackHdPrice"
//        case trackHDRentalPrice = "trackHdRentalPrice"
//        case releaseDate, collectionExplicitness, trackExplicitness, trackTimeMillis, country, currency, primaryGenreName, contentAdvisoryRating, longDescription
    }
}
