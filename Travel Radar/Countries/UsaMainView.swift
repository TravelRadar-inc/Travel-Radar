//
//  UsaMainView.swift
//  Travel Radar
//
//  Created by Артемий Вишняков on 11/13/23.
//

import SwiftUI

struct UsaMainView: View {
    @StateObject var ViewModel = CountriesListViewModel()
    
    var body: some View {
        ZStack {
            Color("lightGray")
                .ignoresSafeArea()
            
            VStack {
                ForEach (ViewModel.countries, id: \.id) {country in
                    MenuView(CountryImage1: "USA1", CountryImage2: "USA2", CountryImage3: "USA3", CountryImage4: "USA4", country: country)
                }
            }
            .onAppear{
                ViewModel.getCountryNetwork(whichCountryToGet1: "IHATEYOUGCSUSA")
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
