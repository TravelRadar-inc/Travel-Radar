//
//  SpainMainView.swift
//  Travel Radar
//
//  Created by Артемий Вишняков on 11/18/23.
//

import SwiftUI

struct SpainMainView: View {
    @StateObject var ViewModel = CountriesListViewModel()
    
    var body: some View {
            VStack {
                ForEach (ViewModel.countries, id: \.id) {country in
                    MenuView(CountryImage1: "Uk1", CountryImage2: "Uk2", CountryImage3: "Uk3", CountryImage4: "Uk4", country: country)
                }
            }
            .onAppear{
                ViewModel.getCountryNetwork(whichCountryToGet1: "Spain")
            }
            .alert(item: $ViewModel.alertItem) { alertItem in
                Alert(title: alertItem.title,
                      message: alertItem.message,
                      dismissButton: alertItem.dismissButton)
            }
    }
    
}

#Preview {
    SpainMainView()
}
