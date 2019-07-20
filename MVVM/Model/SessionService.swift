class SessionService: Authentication {
    func signIn(completion: (SignInResponse) -> Void) {
        // call to backend
        completion(.success(token: "12345", userId: "5678"))
    }
}
