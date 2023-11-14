import SwiftUI

struct GermanyMainView: View {
    @State private var countries: [Country] = []
    
    var body: some View {
            VStack {
                ForEach (countries, id: \.id) {country in
                    MenuView(CountryImage1: "Germany1", CountryImage2: "Germany2", CountryImage3: "Germany3", CountryImage4: "Germany4", country: country)
                }
            }
            .onAppear{
                getGermanyNetwork()
            }
    }
    func getGermanyNetwork() {
        NetworkManager.shared.getGermanyNetwork { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let countries):
                    self.countries = countries
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

#Preview {
    GermanyMainView()
}
