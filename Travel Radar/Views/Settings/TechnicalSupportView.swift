import SwiftUI

struct TechnicalSupportView: View {
    var body: some View {
        Section{
            NavigationLink{
                AdminView()
            } label: {
                Text("Написать в тех поддержку")
            }
        } header: {
            Text("Тех поддержка")
        }
    }
}

#Preview {
    TechnicalSupportView()
}
