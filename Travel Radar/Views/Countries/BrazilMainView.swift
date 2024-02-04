import SwiftUI

struct BrazilMainView: View {
    @StateObject var ViewModel = NetworkCallModel()
    @ObservedObject var discModel = CountriesDiscriptions()
    
    var body: some View {
        ZStack {
            Color("lightGray")
                .ignoresSafeArea()
            
            VStack {
                ForEach (ViewModel.countries, id: \.id) {country in
                    CountryScreenView(CountryImage1: "Brazil1", CountryImage2: "Brazil2", CountryImage3: "Brazil3", CountryImage4: "Brazil4", countryDiscription: discModel.BrazilDiscription, country: country)
                }
            }
            .onAppear{
                ViewModel.getCountryNetwork(whichCountryToGet1: "Brazil")
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
    BrazilMainView()
}
