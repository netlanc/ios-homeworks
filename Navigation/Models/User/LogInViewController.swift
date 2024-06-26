import UIKit

class LogInViewController: UIViewController {
    
    var profileModel: ProfileViewModel
    
    private var loginDelegate: LoginViewControllerDelegate?
    
    var brutForce = BruteForce()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView(frame:CGRect(x: 0, y: 0, width: 100, height: 100))
        let image = UIImage(named: "LogoVK")
        logoImageView.image = image
        
        logoImageView.layer.masksToBounds = true
        logoImageView.autoresizingMask = [.flexibleRightMargin, .flexibleBottomMargin]
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return logoImageView
    }()
    
    private lazy var loginTextField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        textField.placeholder = NSLocalizedString("login.input.username", comment: "Username")
        
        // Чтобы не вводить в форму
        //        #if DEBUG // Схема - Navigation
        //        textField.text = "TestGrut"
        //        #else
        //        textField.text = "user"
        //        #endif
        
        textField.text = "netlanc@yandex.ru"
        
        textField.textColor = UIColor.createColor(anyMode: .gray, darkMode: .lightText)
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.autocapitalizationType = .none
        textField.tintColor = .gray
        
        textField.backgroundColor = .systemGray6
        //        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.frame.size.height = 50
        
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var passwordTextField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        textField.placeholder = NSLocalizedString("login.input.password", comment: "Password")
        
        textField.text = "password1"
        
        textField.textColor = UIColor.createColor(anyMode: .gray, darkMode: .lightText)
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.autocapitalizationType = .none
        textField.tintColor = .gray
        
        textField.backgroundColor = .systemGray6
        textField.isSecureTextEntry = true
        textField.frame.size.height = 50
        
        //        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var viewSeparator: UIView = {
        let separator = UIView()
        
        separator.frame.size.height = 0.5
        separator.backgroundColor = .lightGray
        
        return separator
    }()
    
    private lazy var stackLoginPassword: UIStackView = {
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        
        stackView.backgroundColor = .lightGray
        stackView.layer.cornerRadius = 10
        stackView.layer.borderWidth = 0.5
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        
        self.loginTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.viewSeparator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        self.passwordTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        stackView.addArrangedSubview(self.loginTextField)
        stackView.addArrangedSubview(self.viewSeparator)
        stackView.addArrangedSubview(self.passwordTextField)
        
        return stackView
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        
        let bluePixel = UIImage(named: "blue_pixel")
        
        let alpha08Image = bluePixel?.alpha(0.8)
        
        button.setBackgroundImage(bluePixel, for: .normal)
        button.setBackgroundImage(alpha08Image, for: .highlighted)
        button.setBackgroundImage(alpha08Image, for: .selected)
        button.setBackgroundImage(alpha08Image, for: .disabled)
        
        button.setTitle(NSLocalizedString("login.button.login", comment: "Log In"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(handleLogInPressed), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var faceIDButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.backgroundColor = .blue
        
        button.setTitle(NSLocalizedString("login.button.login_face_id", comment: "Log In FaceID"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(handleFaceIDAuthentication), for: .touchUpInside)
        
        return button
    }()
    
    @objc func handleFaceIDAuthentication() {
            LocalAuthorizationService.defaultService.authorizeIfPossible { [weak self] success in
                guard let self = self else { return }
                if success {
                    // если Face ID прошла успешно, то входим в систему под "user".
                    loginDelegate?.setCurrentUser()
                    
                    profileModel.changeStateIfNeeded()
                    profileModel.showProfile?()
                    
                } else {
                    // Face ID неудачна или была отменена
                    print("FaceID authentication failed")
                }
            }
        }
    private lazy var bruteForceButton: UIButton = {
        let button = UIButton()
        
        button.backgroundColor = .systemGreen
        
        button.setTitle(NSLocalizedString("login.input.title-brtf", comment: "Подобрать пароль"), for: .normal)
        button.setTitle(NSLocalizedString("login.input.title-brtf", comment: "Подбираем пароль"), for: .disabled)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.systemGray6, for: .disabled)
        
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(runBruteForce), for: .touchUpInside)
        
        return button
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        return indicator
    }()
    
    private lazy var noteView: UIView = {
        let noteView = UIView()
        
        
        noteView.layer.cornerRadius = 5
        noteView.layer.borderWidth = 0.5
        noteView.layer.borderColor = UIColor.red.cgColor
        
        noteView.translatesAutoresizingMaskIntoConstraints = false
        
        let noteLabel = UILabel()
        noteLabel.font = UIFont.systemFont(ofSize: 14)
        
//        noteLabel.text = """
//Note
//Еще пользователь
//User login: netlanc@yandex.ru
//Password: password1
//"""
        noteLabel.text = NSLocalizedString("login.label.note", comment: "Подбираем пароль")
        
        noteLabel.textColor = .systemGray
        noteLabel.numberOfLines = 0
        
        noteLabel.translatesAutoresizingMaskIntoConstraints = false
        
        noteView.addSubview(noteLabel)
        
        NSLayoutConstraint.activate([
            
            noteLabel.topAnchor.constraint(equalTo: noteView.topAnchor, constant: 10),
            noteLabel.bottomAnchor.constraint(equalTo: noteView.bottomAnchor, constant: -10),
            noteLabel.leadingAnchor.constraint(equalTo: noteView.leadingAnchor, constant: 10),
            noteLabel.trailingAnchor.constraint(equalTo: noteView.trailingAnchor, constant: -10)
        ])
        return noteView
    }()
    
    // MARK: - Init
    init(profileModel: ProfileViewModel, loginInspector: LoginViewControllerDelegate) {
        self.profileModel = profileModel
        self.loginDelegate = loginInspector
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //        Timer.scheduledTimer(withTimeInterval: 5, repeats: false, block: { _ in
        //            self.showBanner()
        //        })
    }
    
    func showBanner() {
        let bannerViewController = BannerViewController()
        
        bannerViewController.modalTransitionStyle = .coverVertical // flipHorizontal
        bannerViewController.modalPresentationStyle = .pageSheet // pageSheet / overFullScreen
        
        present(bannerViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(logoImageView)
        contentView.addSubview(stackLoginPassword)
        contentView.addSubview(logInButton)
        contentView.addSubview(noteView)
        contentView.addSubview(bruteForceButton)
        contentView.addSubview(activityIndicator)
        contentView.addSubview(faceIDButton)
        
        setupContraints()
    }
    
    //@objc private
    @objc func handleLogInPressed() {
        guard let email = loginTextField.text, let password = passwordTextField.text else {
            runAlert(textAlert: NSLocalizedString("login.error.input-empty", comment: "Заполните пожалуйста логин и пароль"))
            return
        }
        
        // Проверка учетных данных через делегата
        loginDelegate?.check(login: email, password: password) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                
                // По хорошему тут бы еще проверку на существование данных о
                loginDelegate?.setCurrentUser()
                
                profileModel.changeStateIfNeeded()
                profileModel.showProfile?()
                
            case .failure(let error):
                if let authError = error as? AuthError, case .empty(let description) = authError {
//                    print("Error---", description)
                    self.runAlert(textAlert: description)
                } else {
//                    print("Error---", error.localizedDescription)
                    self.runAlert(textAlert: error.localizedDescription)
                }
            }
        }
    }
    
    
    @objc func runBruteForce() {
        
        self.bruteForceButton.backgroundColor = .systemGray3
        self.bruteForceButton.isEnabled = false
        
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
        //self.passwordTextField.isSecureTextEntry = false
        
//        print("Генерируем и подбираем пароль")
        
        let dispatchQueueGlobal = DispatchQueue.global(qos: .background)
        dispatchQueueGlobal.async {
            let passwordGenerate = self.brutForce.generatePassword()
            
//            print("Сгенерироали пароль: ", passwordGenerate)
            let passwordBruteForce = self.brutForce.bruteForce(passwordToUnlock: passwordGenerate)
            
//            print("Подобрали пароль: ", passwordBruteForce)
            
            let dispatchQueueMain = DispatchQueue.main
            dispatchQueueMain.async {
                self.passwordTextField.text = passwordBruteForce
                self.passwordTextField.isSecureTextEntry = false
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
                self.bruteForceButton.isEnabled = true
                self.bruteForceButton.backgroundColor = .systemGreen
            }
        }
    }
    
    
    private func setupContraints() {
        
        let safeAreaGuide = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            
            stackLoginPassword.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackLoginPassword.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            stackLoginPassword.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -16),
            stackLoginPassword.heightAnchor.constraint(equalToConstant: 100.5),
            
            logInButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logInButton.topAnchor.constraint(equalTo: stackLoginPassword.bottomAnchor, constant: 16),
            logInButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            
            faceIDButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            faceIDButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 16),
            faceIDButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -16),
            faceIDButton.heightAnchor.constraint(equalToConstant: 50),
            
            noteView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            noteView.topAnchor.constraint(equalTo: faceIDButton.bottomAnchor, constant: 16),
            noteView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -16),
            
            bruteForceButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            bruteForceButton.topAnchor.constraint(equalTo: noteView.bottomAnchor, constant: 16),
            bruteForceButton.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -16),
            bruteForceButton.heightAnchor.constraint(equalToConstant: 50),
            
            bruteForceButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 20),
            
            activityIndicator.centerXAnchor.constraint(equalTo: stackLoginPassword.centerXAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: stackLoginPassword.bottomAnchor, constant: -16)
            //            activityIndicator.centerYAnchor.constraint(equalTo: bruteForceButton.centerYAnchor)
            
        ])
        
    }
    
    // MARK: - Actions
    
    @objc func willShowKeyboard(_ notification: NSNotification) {
        let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
        scrollView.contentInset.bottom += keyboardHeight ?? 0.0
    }
    
    @objc func willHideKeyboard(_ notification: NSNotification) {
        scrollView.contentInset.bottom = 0.0
    }
    
    // MARK: - Private
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        setupKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeKeyboardObservers()
    }
    
    private func setupKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willShowKeyboard(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willHideKeyboard(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func removeKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
}
