import MapKit
import SwiftUI
final class MapViewModelView: ObservableObject{
    @Published var location: [String: CLLocationCoordinate2D] = ["UK": CLLocationCoordinate2D(latitude: 53.416179, longitude: -1.668185), "US": CLLocationCoordinate2D(latitude: 41.072735, longitude: -98.404930), "France": CLLocationCoordinate2D(latitude: 46.901360, longitude: 2.866568), "Spain": CLLocationCoordinate2D(latitude: 40.176000, longitude: -3.153972), "Portugal": CLLocationCoordinate2D(latitude: 39.461725, longitude: -8.112678), "Ireland": CLLocationCoordinate2D(latitude: 52.986435, longitude: -7.771865), "Germany": CLLocationCoordinate2D(latitude: 51.334271, longitude: 10.389437), "Brazil": CLLocationCoordinate2D(latitude: -9.084577, longitude: -51.042438)]
    @Published var numberCounry: [Int: String] = [0: "UK",1: "US", 2: "France", 3: "Spain", 4: "Portugal", 5: "Ireland", 6: "Germany", 7: "Brazil"]
    @Published var flagCountry: [String: String] = ["UK": "FixedUkFlag", "US": "UsFlag", "France": "FranceFlag", "Spain" : "SpainFlag","Portugal": "PortugalFlag","Ireland": "IrelandFlag", "Germany": "GermanyFlag", "Brazil": "BrazilFlag"]
    @Published var isShowContentView = false
    @Published var camera: MapCameraPosition = .automatic
    @Published var selection: String = "home"
}

struct MainAppView: View {
    @StateObject private var viewModel = MapViewModelView()
    @State private var tabSelection: TabBarItem = .map
    var body: some View {
        NavigationStack{
            CustomTabBarContainerView(selection: $tabSelection){
                CountriesListView()
                    .tabBarItem(tab: .list, selection: $tabSelection)
                MapView()
                    .tabBarItem(tab: .map, selection: $tabSelection)
                SettingsView()
                //Color.red
                    .tabBarItem(tab: .settings, selection: $tabSelection)
            }
        }
        .onAppear{
            let authUser = try? AuthService.shared.getAuthUser()
            self.viewModel.isShowContentView = authUser == nil
        }
        .fullScreenCover(isPresented: $viewModel.isShowContentView, content: {LogInView()
        })
    }
}
#Preview {
    MainAppView()
}
extension MainAppView{
    private var defaultTabView: some View{
        TabView(selection: $viewModel.selection){
            CountriesListView()
                .tabItem {
                    Image(systemName: "list.bullet.clipboard")
                    Text("Список стран")
                }
            MapView()
                .tabItem {
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
}
