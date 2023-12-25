import SwiftUI
struct ButtonMini: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.system(size: 15, weight: .medium))
            .padding(.bottom, 20)
            .padding(.top, 20)
            //.foregroundColor(Color("berusovii"))
    }
}
