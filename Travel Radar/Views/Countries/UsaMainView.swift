import SwiftUI

struct UsaMainView: View {
    @StateObject var ViewModel = NetworkCallModel()
    @ObservedObject var discModel = CountriesDiscriptions()
    
    var body: some View {
        ZStack {
            Color("lightGray")
                .ignoresSafeArea()
            
            VStack {
                ForEach (ViewModel.countries, id: \.id) {country in
                    CountryScreenView(CountryImage1: "USA1", CountryImage2: "USA2", CountryImage3: "USA3", CountryImage4: "USA4", countryDiscription: discModel.UsaDiscription, country: country)
                }
            }
            .onAppear{
                ViewModel.getCountryNetwork(whichCountryToGet1: "USA")
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
    UsaMainView()
}
