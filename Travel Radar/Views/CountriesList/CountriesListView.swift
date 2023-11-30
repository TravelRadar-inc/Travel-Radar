import SwiftUI

struct CountriesListView: View {
    var body: some View {
        NavigationStack{
            List{
                NavigationLink{
                    UKMainView()
                } label:{
                    CountriesListBtnView(flagName: "FixedUkFlag", nameOfCountry: "Великобритания")
                }
                
                NavigationLink{
                    FranceMainView()
                } label:{
                    CountriesListBtnView(flagName: "FranceFlag", nameOfCountry: "Франция")
                }
                
                NavigationLink{
                    GermanyMainView()
                } label:{
                    CountriesListBtnView(flagName: "GermanyFlag", nameOfCountry: "Германия")
                }
                
                NavigationLink{
                    IrelandMainView()
                } label:{
                    CountriesListBtnView(flagName: "IrelandFlag", nameOfCountry: "Ирландия")
                }
                
                NavigationLink{
                    UsaMainView()
                } label:{
                    CountriesListBtnView(flagName: "UsFlag", nameOfCountry: "США")
                }
                
                NavigationLink{
                    SpainMainView()
                } label:{
                    CountriesListBtnView(flagName: "SpainFlag", nameOfCountry: "Испания")
                }
                
                NavigationLink{
                    PortugalMainView()
                } label:{
                    CountriesListBtnView(flagName: "PortugalFlag", nameOfCountry: "Португалия")
                }
                
                NavigationLink{
                    BrazilMainView()
                } label:{
                    CountriesListBtnView(flagName: "BrazilFlag", nameOfCountry: "Бразилия")
                }
            }
        }
        //.navigationTitle("Список стран")
        .listStyle(.grouped)
    }
}

#Preview {
    CountriesListView()
}
