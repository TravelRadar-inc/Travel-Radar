import SwiftUI

struct UKMainView: View {
    @State private var countries: [Country] = []
    
    var body: some View {
            VStack {
                ForEach (countries, id: \.id) {country in
                    MenuView(CountryImage1: "Uk1", CountryImage2: "Uk2", CountryImage3: "Uk3", CountryImage4: "Uk4", country: country)
                }
            }
            .onAppear{
                getUkNetwork()
            }
    }
    func getUkNetwork() {
        NetworkManager.shared.getUkNetwork { result in
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
    UKMainView()
}
