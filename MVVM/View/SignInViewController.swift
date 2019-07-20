import UIKit


class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    private var viewModel: SignInViewModel!
    
    override func viewDidLoad() {
        self.viewModel = SignInViewModel(authentication: SessionService())
        self.viewModel.delegate = self
        self.setUpBindings()
        super.viewDidLoad()
    }
    
    private func setUpBindings() {
        self.emailTextField.addTarget(self, action: #selector(self.credentialsChanged), for: UIControl.Event.editingChanged)
        self.passwordTextField.addTarget(self, action: #selector(self.credentialsChanged), for: UIControl.Event.editingChanged)
        self.signInButton.isEnabled = self.viewModel.isSignInActive
    }
    
    @objc private func credentialsChanged() {
        self.viewModel.emailAddress = self.emailTextField.text ?? ""
        self.viewModel.password = self.passwordTextField.text ?? ""
        self.signInButton.isEnabled = self.viewModel.isSignInActive
    }
    
    @IBAction func signInTapped() {
        self.viewModel.signInTapped()
    }
}

extension SignInViewController: SignInDelegate {
    
    func didSignIn() {
        self.showAlert(title: "Success", message: "Signed In")
        // do smth
    }
    
    func didFailSignIn(message: String) {
        print("Failed: \(message)")
        // do smth
    }
}
