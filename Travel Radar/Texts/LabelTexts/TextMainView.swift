import SwiftUI
struct TextMain: View {
    var text:String
    
    var body: some View {
        Text(text)
            .font(.system(size: 40, weight: .bold, design: .default))
            .cornerRadius(16)
            .padding(.bottom, 300)
    }
}
