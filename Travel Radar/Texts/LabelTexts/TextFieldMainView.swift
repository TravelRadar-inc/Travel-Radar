import SwiftUI
struct TextFieldMain: View {
    @State var World: Binding<String>
    var placeholder: String
    var body: some View {
        TextField(placeholder, text: World)
            .padding()
            .frame(width: 300)
            .background(Color.white)
            .cornerRadius(10)
//            .padding(.bottom)
            .overlay(RoundedRectangle(cornerRadius: 5) .stroke(.black, lineWidth: 0.5))
    }
}

