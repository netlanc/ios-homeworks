import UIKit

class LogInViewController: UIViewController {
    
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
        textField.placeholder = "Username"
        
        textField.textColor = .black
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
        textField.placeholder = "Password"
        
        textField.textColor = .black
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
        
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(handleLogInPressed), for: .touchUpInside)
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(logoImageView)
        contentView.addSubview(stackLoginPassword)
        contentView.addSubview(logInButton)
        
        setupContraints()
        
    }
    
    @objc private func handleLogInPressed() {
        
        //        Делаем валидацию
        //        let username = loginTextField.text
        //        let password = passwordTextField.text
        //
        //        guard let username = username, !username.isEmpty,
        //              let password = password, !password.isEmpty else {
        //            print("Error: Заполните логин и пароль")
        //            return
        //        }
        
        let profileViewController = ProfileViewController()
        profileViewController.title = "Профиль"
        profileViewController.view.backgroundColor = .lightGray
        
        self.navigationController?.pushViewController(profileViewController, animated: true)
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
            logInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 20)
            
            
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
