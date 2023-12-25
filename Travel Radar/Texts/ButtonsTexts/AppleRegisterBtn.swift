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
                .frame(width: 15, height: 15)
            Text(text)
                //.font(.system(size: 19,weight: .bold))
            
        }.padding()
            .padding(.horizontal,22)
            .cornerRadius(10)
            .font(.system(size: 20))
            .foregroundColor(.black)
            .overlay(RoundedRectangle(cornerRadius: 5) .stroke(.black, lineWidth: 0.5))
            .padding(.bottom, 20)
    }
}
