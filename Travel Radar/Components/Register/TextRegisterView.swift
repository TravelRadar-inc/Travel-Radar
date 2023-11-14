import SwiftUI
struct TextRedisterView: View {
    var text: String
    var body: some View {
        Text(text)
            .padding(.horizontal)
            .frame(width: 400)
            .font(.system(size: 24, weight: .bold))
    }
}

