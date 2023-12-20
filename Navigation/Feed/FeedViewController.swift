import UIKit

class FeedViewController: UIViewController {
    
    private let passwordCheck = "12345"
    
    private lazy var textField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding()
        textField.placeholder = "Введите текст…"
        
        textField.font = UIFont.systemFont(ofSize: 15)
        
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 6
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.gray.cgColor
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private lazy var checkGuessButton: CustomButton = {
        let checkGuessButton = CustomButton("Check", .white, .systemGreen, tapButton: { [weak self] in
            
                guard let text = self?.textField.text, let passwordCheck = self?.passwordCheck  else {
                    // тут нужно вывести алер об ошибке
                    self?.runAlert()
                    return
                }
            
                if text.isEmpty {
                    self?.runAlert(textAlert: "Заполните поле с текстом")
                    return
                }
            
                var textLabel = "Секретное слово не верно"
                var textColor: UIColor = .red
            
                if FeedModel().check(text) {
                    textLabel = "Секретное слово введено правильно"
                    textColor = .green
                }
            
                self?.checkLabel.text = textLabel
                self?.checkLabel.textColor = textColor
            
            }
                                            
        )
        
        return checkGuessButton
    }()
    
    private lazy var checkLabel: UILabel = {
        let checkLabel = UILabel()
        checkLabel.text = "Проверка введенного слова"
        checkLabel.font = UIFont.systemFont(ofSize: 14)
        checkLabel.textColor = .gray
        checkLabel.layer.masksToBounds = true
        
        checkLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return checkLabel
    }()
    
    private lazy var postButton1: CustomButton = {
        let postButton1 = CustomButton("Показать пост", .white, .systemBlue, tapButton: { [weak self] in
                self?.showPostButtonTapped()
            }
        )
        
        return postButton1
    }()
    
    private lazy var postButton2: CustomButton = {
        let postButton2 = CustomButton("Читать пост", .white, .systemRed, tapButton: { [weak self] in
                self?.showPostButtonTapped()
            }
        )
        
        return postButton2
    }()
    
        
    private lazy var viewButton1: UIView = {
        let view = UIView()
        view.addSubview(postButton1)
        
        view.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        return view
    }()
    
    private lazy var viewButton2: UIView = {
        let view = UIView()
        view.addSubview(postButton2)
        
        view.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        return view
    }()
    
    private lazy var stackView: UIStackView = { [unowned self] in
        let stackView = UIStackView()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 10.0
        
        stackView.clipsToBounds = false
        
        stackView.addArrangedSubview(self.viewButton1)
        stackView.addArrangedSubview(self.viewButton2)
        
        return stackView
    }()
    
    
    // добавлени кнопке обработчика по нажатию
//    fileprivate func configureShowPostButton() {
//        postButton1.addTarget(self, action: #selector(showPostButtonTapped), for: .touchUpInside)
//        postButton2.addTarget(self, action: #selector(showPostButtonTapped), for: .touchUpInside)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Лента"
        view.backgroundColor = .systemOrange

        view.addSubview(textField)
        view.addSubview(checkGuessButton)
        view.addSubview(checkLabel)
        view.addSubview(stackView)
        
        setupContraints()
//        configureShowPostButton()
    }
    
    private func setupContraints() {
        
        let safeAreaGuide = view.safeAreaLayoutGuide
        
    
        let safeAreaGuideView1 = viewButton1.safeAreaLayoutGuide
        let safeAreaGuideView2 = viewButton2.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            textField.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 16),
            textField.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16),
            
            checkGuessButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16),
            checkGuessButton.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16),
            checkGuessButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16),
            
            checkLabel.topAnchor.constraint(equalTo: checkGuessButton.bottomAnchor, constant: 16),
            checkLabel.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16),
            checkLabel.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16),
//            checkLabel.heightAnchor.constraint(equalToConstant: 30),
            
            stackView.topAnchor.constraint(equalTo: checkLabel.bottomAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            
            postButton1.centerYAnchor.constraint(equalTo: safeAreaGuideView1.centerYAnchor),
            postButton1.leadingAnchor.constraint(equalTo: safeAreaGuideView1.leadingAnchor, constant: 16),
            postButton1.trailingAnchor.constraint(equalTo: safeAreaGuideView1.trailingAnchor, constant: -16),
            postButton1.heightAnchor.constraint(equalToConstant: 50),
            
            postButton2.centerYAnchor.constraint(equalTo: safeAreaGuideView2.centerYAnchor),
            postButton2.leadingAnchor.constraint(equalTo: safeAreaGuideView2.leadingAnchor, constant: 16),
            postButton2.trailingAnchor.constraint(equalTo: safeAreaGuideView2.trailingAnchor, constant: -16),
            postButton2.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @objc private func showPostButtonTapped() {
        let postViewController = PostViewController()
        postViewController.post = posts[0]
        navigationController?.pushViewController(postViewController, animated: true)
    }

}

