import SwiftUI

struct IrelandMainView: View {
    @StateObject var ViewModel = CountriesListViewModel()
    
    var body: some View {
        ZStack {
            Color("lightGray")
                .ignoresSafeArea()
            
            VStack {
                ForEach (ViewModel.countries, id: \.id) {country in
                    MenuView(CountryImage1: "Ireland1", CountryImage2: "Ireland2", CountryImage3: "Ireland3", CountryImage4: "Ireland4", country: country)
                }
            }
            .onAppear{
                ViewModel.getCountryNetwork(whichCountryToGet1: "Ireland")
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
    IrelandMainView()
}
