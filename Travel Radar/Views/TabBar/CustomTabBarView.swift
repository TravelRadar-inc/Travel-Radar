import SwiftUI
struct CustomTabBarView: View {
    let tabs: [TabBarItem]
    @Binding var selection: TabBarItem
    @Namespace private var namespace
    var body: some View {
        tabBarVersion2
    }
}
struct CustomTabBarView_Previews: PreviewProvider{
    static let tabs: [TabBarItem] = [.list, .map, .settings]
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
    
    private var tabBarVersion1: some View{
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
    
    private func switchToTab(tab: TabBarItem){
        withAnimation(.easeInOut){
           selection = tab
        }
    }
}

extension CustomTabBarView{
    private func tabView2(tab: TabBarItem) -> some View{
        VStack{
            Image(systemName: tab.iconName)
            Text(tab.title)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
        }.foregroundColor(.black)
            .padding(.vertical, 8)
            .frame(maxWidth:.infinity)
            .background(
                ZStack{
                    if selection == tab{
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color("conditionsColor").opacity(0.3))
                            .matchedGeometryEffect(id: "background_rectangle", in: namespace)
                    }
                }
            )
            .cornerRadius(16)
    }
    
    private var tabBarVersion2: some View{
        HStack{
            ForEach(tabs, id: \.self) { tab in
                tabView2(tab: tab)
                    .onTapGesture {
                        switchToTab(tab: tab)
                    }
            }
        }
        .padding(6)
        .background(Color.white.ignoresSafeArea(edges: .bottom))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
        .padding(.horizontal)
    }
}
