import SwiftUI
struct CountryTextButton: View {
    @Binding var isShowedView: Bool
    @State var Countryimage: String
    var body: some View {
        Button(action: {
            isShowedView.toggle()
        }, label: {
            Image(Countryimage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 22)
                .cornerRadius(50)
        })
        .padding(5)
        .background(Color(.white))
        .cornerRadius(16)
    }
}


