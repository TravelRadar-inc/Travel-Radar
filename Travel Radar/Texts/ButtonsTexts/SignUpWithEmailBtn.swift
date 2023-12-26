import Foundation
import SwiftUI
struct SignUpWithEmainBtn: View {
    let text:String
    let imageName:String
    var body: some View {
        HStack(spacing: 10){
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 15, height: 15)
            Text(text)
        }
            .padding()
            .frame(width: 320,height: 55)
            .background(Color("darkGray"))
            .cornerRadius(10)
            .padding(.horizontal,5)
            .cornerRadius(10)
            .font(.system(size: 20))
            .foregroundColor(.white)
    }
}
