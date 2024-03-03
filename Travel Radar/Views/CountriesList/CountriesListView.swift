import SwiftUI

struct CountriesListView: View {
    @StateObject var viewModel = MapViewModelView()
    var body: some View {
        NavigationStack{
            List{
                ForEach(viewModel.annotations) { annotation in
                    NavigationLink {
                        Group{
                            AnyView(annotation.view)
                        }
                    } label: {
                        CountriesListBtnView(flagName: annotation.imageName, nameOfCountry: annotation.countyNameRus)
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
