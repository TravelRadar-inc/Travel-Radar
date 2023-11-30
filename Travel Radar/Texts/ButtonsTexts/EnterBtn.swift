import SwiftUI
struct ButtonEnter: View {
    var text: String
    var color:Color
    var body: some View {
        Text(text)
            .padding()
            .background(color)
            .cornerRadius(20)
            .font(.system(size: 30))
            .foregroundColor(.black)
            .padding(.bottom, 20)
    }
}
