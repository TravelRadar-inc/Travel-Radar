import SwiftUI
struct SettingsButtonText: View {
    var body: some View {
        HStack {
            Spacer()
            Image(systemName: "gearshape")
                .resizable()
                .frame(width: 60, height: 60)
            //.background(Color("prosrachniiBerusovii"))
                .background(Color(.gray))
        }
    }
}

#Preview {
    SettingsButtonText()
}
