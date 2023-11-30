import SwiftUI

struct CountriesListBtnView: View {
    var flagName: String
    var nameOfCountry: String
    var body: some View {
        HStack{
            Image(flagName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40)
                .cornerRadius(8)

            Text(nameOfCountry)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .padding(.leading, 20)
        }
    }
}
