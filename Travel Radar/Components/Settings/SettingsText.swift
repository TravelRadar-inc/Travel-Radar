import SwiftUI
struct SettingsText: View {
    var body: some View {
        Text ("Настройки")
            .padding()
            .foregroundColor(.black)
            .font(.custom("MFNQWFO", size: 30))
            .frame(maxWidth: .infinity)
            .background(Color("MainColorPurple"))
            .cornerRadius(16)
    }
}
