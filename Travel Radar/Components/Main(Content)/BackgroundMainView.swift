import SwiftUI
struct BackgroundMain: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color("bleckYellow"), Color("berusovii") ]), startPoint: .bottomLeading, endPoint: .topTrailing)
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}
