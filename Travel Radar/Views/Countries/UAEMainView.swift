//
//  UAEMainView.swift
//  Travel Radar
//
//  Created by Артемий Вишняков on 12/6/23.
//

import SwiftUI

struct UAEMainView: View {
    @StateObject var ViewModel = NetworkCallModel()
    
    var body: some View {
        ZStack {
            Color("lightGray")
                .ignoresSafeArea()
            
            VStack {
                ForEach (ViewModel.countries, id: \.id) {country in
                    CountryScreenView(CountryImage1: "UAE1", CountryImage2: "UAE2", CountryImage3: "UAE3", CountryImage4: "UAE4", country: country)
                }
            }
            .onAppear{
                ViewModel.getCountryNetwork(whichCountryToGet1: "Emirates")
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
    UAEMainView()
}
