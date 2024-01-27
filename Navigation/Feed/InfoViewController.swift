import UIKit
import StorageService

class InfoViewController: UIViewController {
    
    private let titleDefault = "Сейчас что то подгрузится"
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.numberOfLines = 2
        titleLabel.textColor = .black
        
        titleLabel.text = titleDefault
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return titleLabel
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Нажми", for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(titleLabel)
        view.addSubview(button)
        
        setupConstraint()
        getUserNetworkService()
        
    }
    
    private func setupConstraint() {
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -12),
            titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 12),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func getUserNetworkService(){
        
        let url = AppConfiguration.userURL.url
        NetworkService.request(url: url) { result in
            switch result {
            case .success(let data):
                
                do {
                    
                    if let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        
                        if let title = jsonData["title"] as? String {
                            
                            //                                    print("title - ", title)
                            self.titleLabel.text = title
                            
                        }
                        
                    }
                    
                } catch {
                    print("Decode JSON error: \(error)");
                }
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
        
    }
    
    @objc func didTapButton() {
        // Создание UIAlertController
        let alertController = UIAlertController(title: "Заголовок", message: "Сообщение", preferredStyle: .alert)
        
        // Обработка нажатия на Ok
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            print("Вы нажали ОК.")
        }
        
        // Обработка нажатия на Отмена
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { (action) in
            print("Вы нажали Отмена.")
        }
        
        // Добавление кнопок в UIAlertController
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Отображение UIAlertController
        present(alertController, animated: true, completion: nil)
    }
}
