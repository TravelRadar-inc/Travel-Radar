import SwiftUI
struct CustomTabBarView: View {
    let tabs: [TabBarItem]
    @Binding var selection: TabBarItem
    var body: some View {
        HStack{
            ForEach(tabs, id: \.self) { tab in
                tabView(tab: tab)
                    .onTapGesture {
                        switchToTab(tab: tab)
                    }
            }
        }
        .padding(6)
        .background(Color.clear.ignoresSafeArea(edges: .bottom))
    }
}
struct CustomTabBarView_Previews: PreviewProvider{
    static let tabs: [TabBarItem] = [TabBarItem(iconName: "list.bullet.clipboard", title: "Список стран"), TabBarItem(iconName: "map", title: "Карта"), TabBarItem(iconName: "gearshape", title: "Настройки")]
    static var previews: some View{
        CustomTabBarView(tabs: tabs, selection: .constant(tabs.first!))
    }
}

extension CustomTabBarView{
    private func tabView(tab: TabBarItem) -> some View{
        VStack{
            Image(systemName: tab.iconName)
            Text(tab.title)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
        }.foregroundColor(.black)
            .padding(.vertical, 8)
            .frame(maxWidth:.infinity)
            .background(selection == tab ? Color("conditionsColor").opacity(0.4) : Color.clear)
            .cornerRadius(16)
    }
    private func switchToTab(tab: TabBarItem){
        withAnimation(.easeInOut){
           selection = tab
        }
    }
}

struct TabBarItem: Hashable{
    let iconName: String
    let title: String
}
