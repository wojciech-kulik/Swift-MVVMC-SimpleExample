import UIKit
import RxSwift
import RxCocoa

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    private let disposeBag = DisposeBag()
    var viewModel: SignInViewModel?
    
    override func viewDidLoad() {
        self.setUpBindings()
        super.viewDidLoad()
    }
    
    private func setUpBindings() {
        guard let viewModel = viewModel else { return }
        
        self.emailTextField.rx.text.orEmpty
            .bind(to: viewModel.emailAddress)
            .disposed(by: self.disposeBag)
        
        self.passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.password)
            .disposed(by: self.disposeBag)
        
        self.signInButton.rx.tap
            .bind { viewModel.signInTapped() }
            .disposed(by: self.disposeBag)
        
        viewModel.isSignInActive
            .bind(to: self.signInButton.rx.isEnabled)
            .disposed(by: self.disposeBag)
    }
}
