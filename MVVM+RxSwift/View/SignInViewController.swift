import UIKit
import RxSwift
import RxCocoa

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    private let disposeBag = DisposeBag()
    private var viewModel: SignInViewModel!
    
    override func viewDidLoad() {
        self.viewModel = SignInViewModel(authentication: SessionService())
        self.setUpBindings()
        super.viewDidLoad()
    }
    
    private func setUpBindings() {
        self.emailTextField.rx.text.orEmpty
            .bind(to: self.viewModel.emailAddress)
            .disposed(by: self.disposeBag)
        
        self.passwordTextField.rx.text.orEmpty
            .bind(to: self.viewModel.password)
            .disposed(by: self.disposeBag)
        
        self.signInButton.rx.tap
            .bind { [weak self] in self?.viewModel.signInTapped() }
            .disposed(by: self.disposeBag)
        
        self.viewModel.isSignInActive
            .bind(to: self.signInButton.rx.isEnabled)
            .disposed(by: self.disposeBag)
        
        self.viewModel.didSignIn
            .subscribe(onNext: { [weak self] in
                self?.showAlert(title: "Success", message: "Signed in")
                // do smth
            })
            .disposed(by: self.disposeBag)
        
        self.viewModel.didFailSignIn
            .subscribe(onNext: { error in
                print("Failed: \(error)")
                // do smth
            })
            .disposed(by: self.disposeBag)
    }
}
