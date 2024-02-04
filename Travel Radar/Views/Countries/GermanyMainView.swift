import SwiftUI

struct GermanyMainView: View {
    @StateObject var ViewModel = NetworkCallModel()
    @ObservedObject var discModel = CountriesDiscriptions()
    
    var body: some View {
        ZStack {
            Color("lightGray")
                .ignoresSafeArea()
            
            VStack {
                ForEach (ViewModel.countries, id: \.id) {country in
                    CountryScreenView(CountryImage1: "Germany1", CountryImage2: "Germany2", CountryImage3: "Germany3", CountryImage4: "Germany4", countryDiscription: discModel.GermanyDiscription, country: country)
                }
            }
            .onAppear{
                ViewModel.getCountryNetwork(whichCountryToGet1: "Germany")
            }
            .alert(item: $ViewModel.alertItem) { alertItem in
                Alert(title: alertItem.title,
                      message: alertItem.message,
                      dismissButton: alertItem.dismissButton)
        }
        }
    }
}

#Preview {
    GermanyMainView()
}
