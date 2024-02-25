import Foundation
import SwiftUI

struct CustomNavigationBarView: View {
    var title: String
    var onBack: () -> Void

    var body: some View {
        HStack {
            Button(action: onBack) {
                HStack {
                    Image(systemName: "chevron.left")
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.blue)
                    Text("Назад")
                        .foregroundColor(.blue)
                }
            }
            
            Text("        "+title)
                .font(.headline)
                .frame(alignment: .center)
                .foregroundColor(.black)
            Spacer()

        }
        .padding()
    }
}

