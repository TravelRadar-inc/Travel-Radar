import SwiftUI

final class CountriesListViewModel: ObservableObject {
    @Published var countries: [Country] = []
    @Published var alertItem: AlertItem?
    
    func getCountryNetwork(whichCountryToGet1: String) {
        NetworkManager.shared.getCountryNetwork(whichCountryToGet2: whichCountryToGet1) { result in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let countries):
                    self.countries = countries
                case .failure(let error):
                    switch error {
                    case .invalidData:
                        alertItem = AlertContext.invalidData
                    case .invalidURL:
                        alertItem = AlertContext.invalidURL
                    case .invalidResponse:
                        alertItem = AlertContext.invalidResponse
                    case .unableToComplete:
                        alertItem = AlertContext.unableToComplete
                    }
                }
            }
        }
    }
}
