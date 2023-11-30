//
//  BrazilMainView.swift
//  Travel Radar
//
//  Created by Артемий Вишняков on 11/30/23.
//

import SwiftUI

struct BrazilMainView: View {
    @StateObject var ViewModel = CountriesListViewModel()
    
    var body: some View {
        ZStack {
            Color("lightGray")
                .ignoresSafeArea()
            
            VStack {
                ForEach (ViewModel.countries, id: \.id) {country in
                    MenuView(CountryImage1: "Brazil1", CountryImage2: "Brazil2", CountryImage3: "Brazil3", CountryImage4: "Brazil4", country: country)
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
