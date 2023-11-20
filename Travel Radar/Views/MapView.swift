import MapKit
import SwiftUI
final class MapViewModelView: ObservableObject{
    @Published var location: [String: CLLocationCoordinate2D] = ["UK": CLLocationCoordinate2D(latitude: 53.416179, longitude: -1.668185), "US": CLLocationCoordinate2D(latitude: 41.072735, longitude: -98.404930), "France": CLLocationCoordinate2D(latitude: 46.901360, longitude: 2.866568), "Spain": CLLocationCoordinate2D(latitude: 40.176000, longitude: -3.153972), "Portugal": CLLocationCoordinate2D(latitude: 39.461725, longitude: -8.112678), "Ireland": CLLocationCoordinate2D(latitude: 52.986435, longitude: -7.771865), "Germany": CLLocationCoordinate2D(latitude: 51.334271, longitude: 10.389437)]
    @Published var isShowContentView = false
    @Published var camera: MapCameraPosition = .automatic
    @Published var selection: String = "home"
}
struct MapView: View {
    @StateObject private var viewModel = MapViewModelView()
    var body: some View {
        NavigationStack{
            TabView(selection: $viewModel.selection){
                ListCountries()
                    .tabItem {
                        Image(systemName: "list.bullet.clipboard")
                        Text("Список стран")
                    }
                Map(position: $viewModel.camera){
                    //                CountryTextButton1(countryName: "UK", countryImage: "FixedUkFlag", view: UKMainView())
                    //                CountryTextButton1(countryName: "US", countryImage: "UsFlag", view: UsaMainView())
                    //                CountryTextButton1(countryName: "Spain", countryImage: "SpainFlag", view: SpainMainView())
                    //                CountryTextButton1(countryName: "France", countryImage: "FranceFlag", view: UKMainView())
                    //                CountryTextButton1(countryName: "Ireland", countryImage: "IrelandFlag", view: UKMainView())
                    Annotation("",
                               coordinate: viewModel.location["UK"]!) {
                        NavigationLink{
                            UKMainView()
                        } label: {
                            CountryTextButton(Countryimage: "FixedUkFlag")
                        }
                    }
                    Annotation("",
                               coordinate: viewModel.location["Spain"]!) {
                        NavigationLink{
                            UKMainView()
                        } label: {
                            CountryTextButton(Countryimage: "SpainFlag")
                        }
                    }
                    Annotation("",
                               coordinate: viewModel.location["US"]!) {
                        NavigationLink{
                            UKMainView()
                        } label: {
                            CountryTextButton(Countryimage: "UsFlag")
                        }
                    }
                    Annotation("",
                               coordinate: viewModel.location["France"]!) {
                        NavigationLink{
                            UKMainView()
                        } label: {
                            CountryTextButton(Countryimage: "FranceFlag")
                        }
                    }
                    Annotation("",
                               coordinate: viewModel.location["Portugal"]!) {
                        NavigationLink{
                            UKMainView()
                        } label: {
                            CountryTextButton(Countryimage: "PortugalFlag")
                        }
                    }
                    Annotation("",
                               coordinate: viewModel.location["Ireland"]!) {
                        NavigationLink{
                            UKMainView()
                        } label: {
                            CountryTextButton(Countryimage: "IrelandFlag")
                        }
                    }
                    Annotation("",
                               coordinate: viewModel.location["Germany"]!) {
                        NavigationLink{
                            UKMainView()
                        } label: {
                            CountryTextButton(Countryimage: "GermanyFlag")
                        }
                    }
                }.tabItem {
                    Image(systemName: "map")
                    Text("Карта")
                }
                SettingsView()
                    .tabItem {
                        Image(systemName: "gearshape")
                        Text("Настройки")
                    }
            }
        }
        .onAppear{
            let authUser = try? AuthService.shared.getAuthUser()
            self.viewModel.isShowContentView = authUser == nil
        }
        .fullScreenCover(isPresented: $viewModel.isShowContentView, content: {ContentView()
        })
    }
}
struct MapView_Previews: PreviewProvider{
    static var previews: some View{
        NavigationStack{
            MapView()
        }
    }
}
