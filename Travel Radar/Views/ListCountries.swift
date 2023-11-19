//
//  ListCountries.swift
//  Travel Radar
//
//  Created by Mikhail Podalinskii on 11/7/23.
//

import SwiftUI

struct ListCountries: View {
    var body: some View {
        NavigationStack{
            List{
                NavigationLink{
                    UKMainView()
                } label:{
                    ListViewHStack(flagName: "FixedUkFlag", nameOfCountry: "Великобритания")
                }
                
                NavigationLink{
                    UKMainView()
                } label:{
                    ListViewHStack(flagName: "FranceFlag", nameOfCountry: "Франция")
                }
                
                NavigationLink{
                    GermanyMainView()
                } label:{
                    ListViewHStack(flagName: "GermanyFlag", nameOfCountry: "Германия")
                }
                
                NavigationLink{
                    UKMainView()
                } label:{
                    ListViewHStack(flagName: "IrelandFlag", nameOfCountry: "Ирландия")
                }
                
                NavigationLink{
                    UsaMainView()
                } label:{
                    ListViewHStack(flagName: "UsFlag", nameOfCountry: "США")
                }
                
                NavigationLink{
                    UKMainView()
                } label:{
                    ListViewHStack(flagName: "SpainFlag", nameOfCountry: "Испания")
                }
                
                NavigationLink{
                    UKMainView()
                } label:{
                    ListViewHStack(flagName: "PortugalFlag", nameOfCountry: "Португалия")
                }
                
                
            }
        }
        //.navigationTitle("Список стран")
        .listStyle(.grouped)
    }
}

#Preview {
    ListCountries()
}
