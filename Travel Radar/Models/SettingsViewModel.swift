import Foundation

class SettingsViewModel: ObservableObject{
    @Published var authProviders: [AuthProviderOption] = []
    func loadAuthProviders(){
        if let authProviders = try? AuthService.shared.getProviders(){
        }
    }
    func signOut() throws{
        try AuthService.shared.signOut()
    }
    func resetPassword() async throws{
        let authUser = try AuthService.shared.getAuthUser()
        guard let email = authUser.email else{
            throw URLError(.fileDoesNotExist)
        }
        try await AuthService.shared.resetPassword(email: email)
    }
    func updateEmail() async throws{
        let email = "test2@test.ru"
        try await AuthService.shared.updateEmail(email: email)
    }
    func updatePassword() async throws{
        let password = "hello123"
        try await AuthService.shared.updatePassword(password: password)
    }
}
