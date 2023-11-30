//
//  PortugalMainView.swift
//  Travel Radar
//
//  Created by Артемий Вишняков on 11/30/23.
//

import SwiftUI

struct PortugalMainView: View {
    @StateObject var ViewModel = CountriesListViewModel()
    
    var body: some View {
        ZStack {
            Color("lightGray")
                .ignoresSafeArea()
            
            VStack {
                ForEach (ViewModel.countries, id: \.id) {country in
                    MenuView(CountryImage1: "Portugal1", CountryImage2: "Portugal2", CountryImage3: "Portugal3", CountryImage4: "Portugal4", country: country)
                }
            }
            .onAppear{
                ViewModel.getCountryNetwork(whichCountryToGet1: "Portugal")
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
    PortugalMainView()
}
