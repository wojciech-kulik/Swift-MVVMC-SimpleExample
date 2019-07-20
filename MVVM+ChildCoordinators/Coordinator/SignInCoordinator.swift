import RxSwift

class SignInCoordinator: BaseCoordinator {
    
    private let disposeBag = DisposeBag()
    
    override func start() {
        let viewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateInitialViewController()
        guard let signInViewController = viewController as? SignInViewController else { return }
        
        // Now Coordinator initializes and injects viewModel
        let signInViewModel = SignInViewModel(authentication: SessionService())
        signInViewController.viewModel = signInViewModel
        
        // Coordinator subscribes to events and notifies parentCoordinator
        signInViewModel.didSignIn
            .subscribe(onNext: { [weak self] in
                guard let `self` = self else { return }
                self.navigationController.viewControllers = []
                self.parentCoordinator?.didFinish(coordinator: self)
                (self.parentCoordinator as? SignInListener)?.didSignIn()
            })
            .disposed(by: self.disposeBag)
        
        self.navigationController.viewControllers = [signInViewController]
    }
}
