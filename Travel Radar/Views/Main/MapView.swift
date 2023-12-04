import MapKit
import SwiftUI
struct MapView: View {
    @StateObject var viewModel = MapViewModelView()
    var body: some View {
        Map(position: $viewModel.camera){
            ForEach(0..<8){index in
                Annotation("",
                           coordinate: viewModel.location[viewModel.numberCounry[index]!]!) {
                    NavigationLink{
                        AnyView(viewModel.countryView[viewModel.numberCounry[index]!]!)
                    } label: {
                        CountryTextButton(countryImage: viewModel.flagCountry[viewModel.numberCounry[index]!]!)
                    }
                }
            }
        }
    }
}

#Preview {
    MapView()
}
