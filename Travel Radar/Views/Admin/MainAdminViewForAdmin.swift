import SwiftUI
struct MainAdminViewForAdmin: View {
    @State private var tabSelection: TabBarItem = .admin
    @StateObject private var viewModel = MapViewModelView()
    @State var settingsModel = SettingsView()
    var body: some View {
        NavigationStack{
            CustomTabBarContainerView(selection: $tabSelection){
                AdminViewForAdmin()
                    .tabBarItem(tab: .admin, selection: $tabSelection)
                CountriesListView()
                    .tabBarItem(tab: .list, selection: $tabSelection)
                MapView(styleForMap: settingsModel.$styleOfMap)
                    .tabBarItem(tab: .map, selection: $tabSelection)
                SettingsView()
                    .tabBarItem(tab: .settings, selection: $tabSelection)
            }
        }
    }
}

#Preview {
    MainAdminViewForAdmin()
}
