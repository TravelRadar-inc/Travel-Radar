import SwiftUI

struct PasswordFieldView: View {
    @State var World: Binding<String>
    var placeholder: String
    var body: some View {
        SecureField(placeholder, text: World)
            .padding()
            .frame(width: 300)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.bottom)
    }
}
