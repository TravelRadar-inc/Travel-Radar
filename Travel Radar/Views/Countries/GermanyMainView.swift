import SwiftUI

struct GermanyMainView: View {
    @StateObject var ViewModel = NetworkCallModel()
    
    var body: some View {
        ZStack {
            Color("lightGray")
                .ignoresSafeArea()
            
            VStack {
                ForEach (ViewModel.countries, id: \.id) {country in
                    CountryScreenView(CountryImage1: "Germany1", CountryImage2: "Germany2", CountryImage3: "Germany3", CountryImage4: "Germany4", country: country)
                }
            }
            .onAppear{
                ViewModel.getCountryNetwork(whichCountryToGet1: "Germany2")
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
