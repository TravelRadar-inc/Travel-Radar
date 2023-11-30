import SwiftUI
struct CustomTabBarContainerView<Content: View>: View {
    let content: Content
    @Binding var selection: TabBarItemModel
    @State private var tabs: [TabBarItemModel] = []
    init(selection: Binding<TabBarItemModel>, @ViewBuilder content: () -> Content){
        self._selection = selection
        self.content = content()
    }
    var body: some View {
        VStack(spacing: 0){
            ZStack{
                content
            }
            CustomTabBarView(tabs: tabs, selection: $selection)
        }
    }
}

struct CustomTabBarContainerView_Previews: PreviewProvider{
    static let tabs: [TabBarItemModel] = [TabBarItemModel(iconName: "list.bullet.clipboard", title: "Список стран"), TabBarItemModel(iconName: "map", title: "Карта"), TabBarItemModel(iconName: "gearshape", title: "Настройки")]
    static var previews: some View{
        CustomTabBarContainerView(selection: .constant(tabs.first!)) {
            CountriesListView()
        }
    }
}
