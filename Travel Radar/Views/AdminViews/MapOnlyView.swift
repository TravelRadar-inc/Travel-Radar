import MapKit
import SwiftUI
struct MapOnlyView: View {
    @State var countryView: [String: any View] = ["UK" : UKMainView(), "US": UsaMainView(), "France": FranceMainView(), "Spain": SpainMainView(), "Portugal": PortugalMainView(), "Ireland": IrelandMainView(), "Germany": GermanyMainView(), "Brazil": BrazilMainView()]
    @StateObject var viewModel = MapViewModelView()
    var body: some View {
        Map(position: $viewModel.camera){
            ForEach(0..<8){index in
                Annotation("",
                           coordinate: viewModel.location[viewModel.numberCounry[index]!]!) {
                    NavigationLink{
                        AnyView(countryView[viewModel.numberCounry[index]!]!)
                    } label: {
                        CountryTextButton(countryImage: viewModel.flagCountry[viewModel.numberCounry[index]!]!)
                    }
                }
            }
        }
    }
}
#Preview {
    MapOnlyView()
}
