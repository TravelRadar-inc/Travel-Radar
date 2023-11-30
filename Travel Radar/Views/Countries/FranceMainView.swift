import SwiftUI

struct FranceMainView: View {
    @StateObject var ViewModel = NetworkCallModel()
    
    var body: some View {
        ZStack {
            Color("lightGray")
                .ignoresSafeArea()
            
            VStack {
                ForEach (ViewModel.countries, id: \.id) {country in
                    CountryScreenView(CountryImage1: "France1", CountryImage2: "France2", CountryImage3: "France3", CountryImage4: "France4", country: country)
                }
            }
            .onAppear{
                ViewModel.getCountryNetwork(whichCountryToGet1: "France")
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
    FranceMainView()
}
