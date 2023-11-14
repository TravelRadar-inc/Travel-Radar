//
//  UsaMainView.swift
//  Travel Radar
//
//  Created by Артемий Вишняков on 11/13/23.
//

import SwiftUI

struct UsaMainView: View {
    @State private var countries: [Country] = []
    
    var body: some View {
            VStack {
                ForEach (countries, id: \.id) {country in
                    MenuView(CountryImage1: "USA1", CountryImage2: "USA2", CountryImage3: "USA3", CountryImage4: "USA4", country: country)
                }
            }
            .onAppear{
                getUsaNetwork()
            }
    }
    func getUsaNetwork() {
        NetworkManager.shared.getUsaNetwork { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let countries):
                    self.countries = countries
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

#Preview {
    UsaMainView()
}
