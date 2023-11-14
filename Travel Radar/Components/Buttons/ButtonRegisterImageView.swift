import SwiftUI
struct ButtonRegisterImageView: View {
    var imageName:String
    var text:String
    var body: some View {
        HStack(spacing: 10){
            Image(imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
            Text(text)
        }.padding()
            //.padding(.horizontal, 25)
            .background(Color("prosrachniiBerusovii"))
            .cornerRadius(20)
            .font(.system(size: 20))
            .foregroundColor(.black)
            .padding(.bottom, 20)
    }
}
