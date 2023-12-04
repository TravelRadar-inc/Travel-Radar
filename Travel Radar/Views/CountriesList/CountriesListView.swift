import SwiftUI

struct CountriesListView: View {
    @StateObject var viewModel = MapViewModelView()
    var body: some View {
        NavigationStack{
            List{
                ForEach(0..<8) { index in
                    NavigationLink {
                        AnyView(viewModel.countryView[viewModel.numberCounry[index]!]!)
                    } label: {
                        CountriesListBtnView(flagName: viewModel.flagCountry[viewModel.numberCounry[index]!]!, nameOfCountry: viewModel.countryRusNames[index])
                    }
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
