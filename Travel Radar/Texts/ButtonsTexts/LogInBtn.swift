import Foundation
import SwiftUI
struct LogInBtn: View {
    let text: String
    var body: some View {
        Text(text)
            .padding()
            .frame(width: 310,height: 55)
            .background(Color(.black))
            .padding(.horizontal,5)
            .font(.system(size: 20))
            .foregroundColor(.white)
            .overlay(RoundedRectangle(cornerRadius: 10) .stroke(Color("darkGray"), lineWidth: 2))
            
    }
}
