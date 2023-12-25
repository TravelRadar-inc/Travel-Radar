import SwiftUI
struct ButtonEnter: View {
    var text: String
    var color:Color
    var body: some View {
        Text(text)
            .padding()
            .background(color)
            .cornerRadius(20)
            .font(.system(size: 25))
            .foregroundColor(.black)
            .padding(.horizontal, 15)
            .overlay(RoundedRectangle(cornerRadius: 10) .stroke(.black, lineWidth: 1))
            .padding(.top, 20)

    }
}
