import SwiftUI
struct CustomTabBarContainerView<Content: View>: View {
    let content: Content
    @Binding var selection: TabBarItem
    @State private var tabs: [TabBarItem] = []
    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content){
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
    static let tabs: [TabBarItem] = [TabBarItem(iconName: "list.bullet.clipboard", title: "Список стран"), TabBarItem(iconName: "map", title: "Карта"), TabBarItem(iconName: "gearshape", title: "Настройки")]
    static var previews: some View{
        CustomTabBarContainerView(selection: .constant(tabs.first!)) {
            ListCountries()
        }
    }
}
