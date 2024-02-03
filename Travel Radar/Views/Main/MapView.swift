import MapKit
import SwiftUI

struct MapView: View {
    @StateObject var viewModel = MapViewModelView()
    @State var viewModelStyle = SettingsView()
    @Binding var styleForMap: MapStyle
//    @Binding var mapType: MKMapType
    var body: some View {
        Map(position: $viewModel.camera){
            ForEach(0..<10){index in
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
        .mapStyle(styleForMap)
    }
}

