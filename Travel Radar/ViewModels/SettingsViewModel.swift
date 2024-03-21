import Foundation

class SettingsViewModel: ObservableObject{
    @Published var authProviders: [AuthProviderOption] = []
    
    @Published var authUser: AuthDataResultModel? = nil
    
    func loadUser() {
        self.authUser = try? AuthService.shared.getAuthUser()
    }
    
    func loadAuthProviders(){
        if let providers = try? AuthService.shared.getProviders(){
            authProviders = providers
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
    func updateEmail(email: String) async throws{
        try await AuthService.shared.updateEmail(email: email)
    }
    func updatePassword(password: String) async throws{
        try await AuthService.shared.updatePassword(password: password)
    }
    
    func deleteAccount() async throws{
        try await AuthService.shared.delete()
    }
}
