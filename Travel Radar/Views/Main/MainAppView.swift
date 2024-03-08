import MapKit
import SwiftUI
import Firebase
final class MapViewModelView: ObservableObject{
    @Published var annotations: [CountryAnnotation] = [CountryAnnotation(countryName: "UK", countyNameRus: "Великобритания", coordinate: CLLocationCoordinate2D(latitude: 53.416179, longitude: -1.668185), imageName: "FixedUkFlag", view: AnyView(UKMainView())), CountryAnnotation(countryName: "US", countyNameRus: "США", coordinate: CLLocationCoordinate2D(latitude: 41.072735, longitude: -98.404930), imageName: "UsFlag", view: AnyView(UsaMainView())), CountryAnnotation(countryName: "France", countyNameRus: "Франци", coordinate: CLLocationCoordinate2D(latitude: 46.901360, longitude: 2.866568), imageName: "FranceFlag", view: AnyView(FranceMainView())), CountryAnnotation(countryName: "Spain", countyNameRus: "Испания", coordinate: CLLocationCoordinate2D(latitude: 40.176000, longitude: -3.153972), imageName: "SpainFlag", view: AnyView(SpainMainView())), CountryAnnotation(countryName: "Portugal", countyNameRus: "Португалия", coordinate: CLLocationCoordinate2D(latitude: 39.461725, longitude: -8.112678), imageName: "PortugalFlag", view: AnyView(PortugalMainView())), CountryAnnotation(countryName: "Ireland", countyNameRus: "Ирландия", coordinate: CLLocationCoordinate2D(latitude: 52.986435, longitude: -7.771865), imageName: "IrelandFlag", view: AnyView(IrelandMainView())), CountryAnnotation(countryName: "Germany", countyNameRus: "Германия", coordinate: CLLocationCoordinate2D(latitude: 51.334271, longitude: 10.389437), imageName: "GermanyFlag", view: AnyView(GermanyMainView())), CountryAnnotation(countryName: "Brazil", countyNameRus: "Бразилия", coordinate: CLLocationCoordinate2D(latitude: -9.084577, longitude: -51.042438), imageName: "BrazilFlag", view: AnyView(BrazilMainView())), CountryAnnotation(countryName: "UAE", countyNameRus: "ОАЭ", coordinate: CLLocationCoordinate2D(latitude: 23.909297, longitude: 54.695971), imageName: "UAEFlag", view: AnyView(UAEMainView())), CountryAnnotation(countryName: "Turkey", countyNameRus: "Турция", coordinate: CLLocationCoordinate2D(latitude: 38.692537, longitude: 35.629897), imageName: "TurkeyFlag", view: AnyView(TurkeyMainView()))]
    @Published var isShowContentView = false
    @Published var camera: MapCameraPosition = .automatic
    @Published var selection: String = "home"
    @Published var isShowAdminView = false
}

struct MainAppView: View {
    @StateObject private var viewModel = MapViewModelView()
    @State var settingsModel = SettingsView()
    @State private var tabSelection: TabBarItem = .map
    var body: some View {
        NavigationStack{
            CustomTabBarContainerView(selection: $tabSelection){
                CountriesListView()
                    .tabBarItem(tab: .list, selection: $tabSelection)
                MapView()
                    .tabBarItem(tab: .map, selection: $tabSelection)
                SettingsView()
                    .tabBarItem(tab: .settings, selection: $tabSelection)
                
            }
        }
        .onAppear{
            let authUser = try? AuthService.shared.getAuthUser()
            self.viewModel.isShowContentView = authUser == nil
        }
        .onAppear{
            if let user = Auth.auth().currentUser{
                if user.uid == "M0utShwhVqgrtBI2TI2yKo0eNfR2" || user.uid == "Z9GVW4GMORPBPfQUOvX1UTarnl23"{
                    viewModel.isShowAdminView.toggle()
                }
            }
        }
        .fullScreenCover(isPresented: $viewModel.isShowContentView, content: {MainLogInView()
        })
        .fullScreenCover(isPresented: $viewModel.isShowAdminView, content: {
            MainAdminViewForAdmin()
        })
    }
}
#Preview {
    MainAppView()
}
