import MapKit
import SwiftUI
struct MapView: View {
    @StateObject var viewModel = MapViewModelView()
    @State var viewModelStyle = SettingsView()
    var body: some View {
        Map(position: $viewModel.camera) {
            ForEach(viewModel.annotations){annotation in
                Annotation("", coordinate: annotation.coordinate) {
                    NavigationLink {
                        AnyView(annotation.view)
                    } label: {
                        Image(annotation.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22)
                            .cornerRadius(50)
                            .padding(5)
                            .background(Color(.white))
                            .cornerRadius(16)
                    }
                    
                }
            }
        }
    }
}

struct CountryAnnotation: Identifiable {
    let id = UUID()
    let countryName: String
    let countyNameRus: String
    let coordinate: CLLocationCoordinate2D
    let imageName: String
    let view: any View
}

