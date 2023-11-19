import Foundation

struct Country: Decodable{
    let id: Int
    let name: String
    let borders: String
    let tickets: String
    let visa: String
    let documents1: String
    var documents2: String
    let discription: String
}

struct CountryResponse: Decodable{
    let request: [Country]
}

