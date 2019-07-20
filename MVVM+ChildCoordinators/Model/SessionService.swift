import RxSwift

class SessionService: Authentication {
    func signIn() -> Single<SignInResponse> {
        return Single<SignInResponse>.create { single in
            // call to backend
            single(.success(SignInResponse.success(token: "12345", userId: "5678")))
            return Disposables.create()
        }
    }
}
