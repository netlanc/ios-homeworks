import UIKit

class FeedViewController: UIViewController {
    
//    let post = Post(title: "Заголовок поста")
    
    private lazy var postButton1: UIButton = {
        let postButton1 = UIButton()
        postButton1.setTitle("Показать пост", for: .normal)
        postButton1.setTitleColor(.white, for: .normal)
        
        postButton1.backgroundColor = .systemBlue
        postButton1.layer.cornerRadius = 4
        postButton1.layer.shadowRadius = 4
        postButton1.layer.shadowColor = UIColor.black.cgColor
        postButton1.layer.shadowOffset.width = 4
        postButton1.layer.shadowOffset.height = 4
        postButton1.layer.shadowOpacity = 0.7
        postButton1.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        
        postButton1.translatesAutoresizingMaskIntoConstraints = false
        
        return postButton1
    }()
    
    private lazy var postButton2: UIButton = {
        
        let postButton2 = UIButton(frame: CGRect(x:0,y:0,width:200,height:150))
        postButton2.setTitle("Читать пост", for: .normal)
        postButton2.setTitleColor(.white, for: .normal)
        
        postButton2.backgroundColor = .systemRed
        postButton2.layer.cornerRadius = 4
        postButton2.layer.shadowRadius = 4
        postButton2.layer.shadowColor = UIColor.black.cgColor
        postButton2.layer.shadowOffset.width = 4
        postButton2.layer.shadowOffset.height = 4
        postButton2.layer.shadowOpacity = 0.7
        postButton2.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        
        postButton2.translatesAutoresizingMaskIntoConstraints = false
        
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
        
//        stackView.addArrangedSubview(self.postButton1)
        stackView.addArrangedSubview(self.viewButton1)
        stackView.addArrangedSubview(self.viewButton2)
        
        return stackView
    }()
    
    
    // добавлени кнопке обработчика по нажатию
    fileprivate func configureShowPostButton() {
        postButton1.addTarget(self, action: #selector(showPostButtonTapped), for: .touchUpInside)
        postButton2.addTarget(self, action: #selector(showPostButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Лента"
        self.view.backgroundColor = .systemOrange

        self.view.addSubview(stackView)
        
        setupContraints()
        configureShowPostButton()
    }
    
    private func setupContraints() {
        
        let safeAreaGuide = self.view.safeAreaLayoutGuide
        
    
        let safeAreaGuideView1 = self.viewButton1.safeAreaLayoutGuide
        let safeAreaGuideView2 = self.viewButton2.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            stackView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            
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
    
    @objc private func showPostButtonTapped() {
        let postViewController = PostViewController()
//        postViewController.post = post
        self.navigationController?.pushViewController(postViewController, animated: true)
    }

}

