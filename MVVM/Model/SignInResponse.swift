enum SignInResponse {
    case success(token: String, userId: String)
    case error(message: String)
}
