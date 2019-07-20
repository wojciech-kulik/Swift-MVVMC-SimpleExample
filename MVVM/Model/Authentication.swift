protocol Authentication {
    func signIn(completion: (SignInResponse) -> Void)
}
