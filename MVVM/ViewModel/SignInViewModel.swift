protocol SignInDelegate {
    func didSignIn()
    func didFailSignIn(message: String)
}

class SignInViewModel {
    
    private let authentication: Authentication
    var delegate: SignInDelegate?
    
    var emailAddress = ""
    var password = ""
    var isSignInActive: Bool {
        // business logic like validation could be extracted to model
        return self.emailAddress != "" && self.password != ""
    }
    
    init(authentication: Authentication) {
        self.authentication = authentication
    }
    
    func signInTapped() {
        self.authentication.signIn { [weak self] response in
            guard let delegate = self?.delegate else { return }
            
            if case .success(_) = response {
                delegate.didSignIn()
            } else if case .error(let message) = response {
                delegate.didFailSignIn(message: message)
            }
        }
    }
}
