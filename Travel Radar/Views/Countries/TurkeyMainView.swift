//
//  TurkeyMainView.swift
//  Travel Radar
//
//  Created by Артемий Вишняков on 12/6/23.
//

import SwiftUI

struct TurkeyMainView: View {
    @StateObject var ViewModel = NetworkCallModel()
    
    var body: some View {
        ZStack {
            Color("lightGray")
                .ignoresSafeArea()
            
            VStack {
                ForEach (ViewModel.countries, id: \.id) {country in
                    CountryScreenView(CountryImage1: "Turkey1", CountryImage2: "Turkey2", CountryImage3: "Turkey3", CountryImage4: "Turkey4", country: country)
                }
            }
            .onAppear{
                ViewModel.getCountryNetwork(whichCountryToGet1: "Turkey")
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
    TurkeyMainView()
}
