//import Foundation
//import SwiftUI
//import GoogleSignIn
//import GoogleSignInSwift
//import FirebaseAuth
//class AuthGoogleViewModel: ObservableObject{
//    func singInGoogle() async throws{
//        guard let topVC = await Utilities.shared.topViewController() else{
//            throw URLError(.cannotFindHost)
//        }
//        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
//        guard let idToken = gidSignInResult.user.idToken?.tokenString else{
//            throw URLError(.badServerResponse)
//        }
//        let accessToken = gidSignInResult.user.accessToken.tokenString
//        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
//    }
//}
