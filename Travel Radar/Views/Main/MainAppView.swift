import MapKit
import SwiftUI
import Firebase
final class MapViewModelView: ObservableObject{
    @Published var location: [String: CLLocationCoordinate2D] = ["UK": CLLocationCoordinate2D(latitude: 53.416179, longitude: -1.668185), "US": CLLocationCoordinate2D(latitude: 41.072735, longitude: -98.404930), "France": CLLocationCoordinate2D(latitude: 46.901360, longitude: 2.866568), "Spain": CLLocationCoordinate2D(latitude: 40.176000, longitude: -3.153972), "Portugal": CLLocationCoordinate2D(latitude: 39.461725, longitude: -8.112678), "Ireland": CLLocationCoordinate2D(latitude: 52.986435, longitude: -7.771865), "Germany": CLLocationCoordinate2D(latitude: 51.334271, longitude: 10.389437), "Brazil": CLLocationCoordinate2D(latitude: -9.084577, longitude: -51.042438), "UAE":
        CLLocationCoordinate2D(latitude: 23.909297, longitude: 54.695971), "Turkey":
        CLLocationCoordinate2D(latitude: 38.692537, longitude: 35.629897)
    ]
    @Published var numberCounry: [Int: String] = [0: "UK",1: "US", 2: "France", 3: "Spain", 4: "Portugal", 5: "Ireland", 6: "Germany", 7: "Brazil", 8: "UAE", 9: "Turkey"]
    @Published var flagCountry: [String: String] = ["UK": "FixedUkFlag", "US": "UsFlag", "France": "FranceFlag", "Spain" : "SpainFlag","Portugal": "PortugalFlag","Ireland": "IrelandFlag", "Germany": "GermanyFlag", "Brazil": "BrazilFlag", "UAE": "UAEFlag", "Turkey": "TurkeyFlag"]
    @Published var countryView: [String: any View] = ["UK" : UKMainView(), "US": UsaMainView(), "France": FranceMainView(), "Spain": SpainMainView(), "Portugal": PortugalMainView(), "Ireland": IrelandMainView(), "Germany": GermanyMainView(), "Brazil": BrazilMainView(), "UAE": UAEMainView(), "Turkey": TurkeyMainView()]
    @Published var countryRusNames: [String] = ["Великобритания", "США", "Франция", "Испания", "Португалия", "Ирландия", "Германия", "Бразилия", "ОАЭ", "Турция"]
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
                MapView(styleForMap: settingsModel.$styleOfMap)
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
                if user.uid == "mDMX2tTyvYfM8qtCRWdgaMaMa7l2" || user.uid == "Z9GVW4GMORPBPfQUOvX1UTarnl23"{
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
