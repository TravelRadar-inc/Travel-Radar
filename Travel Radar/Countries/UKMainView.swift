import SwiftUI

struct UKMainView: View {
    @StateObject var ViewModel = CountriesListViewModel()
    
    var body: some View {
            VStack {
                ForEach (ViewModel.countries, id: \.id) {country in
                    MenuView(CountryImage1: "Uk1", CountryImage2: "Uk2", CountryImage3: "Uk3", CountryImage4: "Uk4", country: country)
                }
            }
            .onAppear{
                ViewModel.getCountryNetwork(whichCountryToGet1: "UK")
            }
            .alert(item: $ViewModel.alertItem) { alertItem in
                Alert(title: alertItem.title, 
                      message: alertItem.message,
                      dismissButton: alertItem.dismissButton)
            }
    }
    
}

#Preview {
    UKMainView()
}
