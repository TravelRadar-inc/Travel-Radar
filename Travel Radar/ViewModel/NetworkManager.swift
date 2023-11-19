import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://storage.googleapis.com/travel_radar/"
    
    private init() {}
    
    func getCountryNetwork (whichCountryToGet2: String, completed: @escaping (Result<[Country], APError>) -> Void) {
        guard let url = URL(string: baseURL + whichCountryToGet2 + ".json") else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else{
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(CountryResponse.self, from: data)
                completed(.success(decodedResponse.request))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
