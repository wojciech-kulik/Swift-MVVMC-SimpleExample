import RxSwift

protocol Authentication {
    func signIn() -> Single<SignInResponse>
}
