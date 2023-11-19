import MapKit
import SwiftUI
struct MapView: View {
    @State private var isShowContentView = false
    @State var camera: MapCameraPosition = .automatic
    @State var isShowedSettingsView = false
    @State var isShowedUKView = false
    @State var isShowedUSView = false
    @State var isShowedFranceView = false
    @State var isShowedSpainView = false
    @State var isShowedPortugalView = false
    @State var isShowedIrelandView = false
    @State var isShowedGermanyView = false
    @State private var selection: String = "home"
    let UK = CLLocationCoordinate2D(
        latitude: 53.416179,
        longitude: -1.668185)
    let US = CLLocationCoordinate2D(
        latitude: 41.072735,
        longitude: -98.404930)
    let France = CLLocationCoordinate2D(
        latitude: 46.901360,
        longitude: 2.866568)
    let Spain = CLLocationCoordinate2D(
        latitude: 40.176000,
        longitude: -3.153972)
    let Portugal = CLLocationCoordinate2D(
        latitude: 39.461725,
        longitude: -8.112678)
    let Ireland = CLLocationCoordinate2D(
        latitude: 52.986435,
        longitude: -7.771865)
    let Germany = CLLocationCoordinate2D(
        latitude: 51.334271,
        longitude: 10.389437)
    var body: some View {
        TabView(selection: $selection){
        // NavigationStack{
            ListCountries()
                .tabItem {
                    Image(systemName: "list.bullet.clipboard")
                    Text("Список стран")
                }
            Map(position: $camera){
                Annotation("",
                           coordinate: UK) {
                    CountryTextButton(isShowedView: $isShowedUKView, Countryimage: "FixedUkFlag")
                }
                
                Annotation("",
                           coordinate: US) {
                    CountryTextButton(isShowedView: $isShowedUSView, Countryimage: "UsFlag")
                }
                
                Annotation("",
                           coordinate: France) {
                    CountryTextButton(isShowedView: $isShowedFranceView, Countryimage: "FranceFlag")
                }
                
                Annotation("",
                           coordinate: Spain) {
                    CountryTextButton(isShowedView: $isShowedSpainView, Countryimage: "SpainFlag")
                }
                
                Annotation("",
                           coordinate: Portugal) {
                    CountryTextButton(isShowedView: $isShowedPortugalView, Countryimage: "PortugalFlag")
                }
                
                Annotation("",
                           coordinate: Ireland) {
                    CountryTextButton(isShowedView: $isShowedIrelandView, Countryimage: "IrelandFlag")
                }
                
                Annotation("",
                           coordinate: Germany) {
                    CountryTextButton(isShowedView: $isShowedGermanyView, Countryimage: "GermanyFlag")
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
//            .safeAreaInset(edge: .top) {
//                NavigationStack{
//                    HStack{
//                        NavigationLink{
//                            SettingsView()
//                        } label: {
//                            SettingsButtonText()
//                        }
//                    }
//                }
//            }
        }
        .onAppear{
            let authUser = try? AuthService.shared.getAuthUser()
            self.isShowContentView = authUser == nil
        }
        .fullScreenCover(isPresented: $isShowContentView, content: {ContentView()
        })
        .sheet(isPresented: $isShowedUKView, content: {
            UKMainView()
        })
        .sheet(isPresented: $isShowedUSView, content: {
            UsaMainView()
        })
        .sheet(isPresented: $isShowedGermanyView, content: {
            GermanyMainView()
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
