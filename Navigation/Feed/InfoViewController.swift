import UIKit
import StorageService

class InfoViewController: UIViewController {
    
    private var dataRepository: DataRepository?
    
    private let titleDefault = "Сейчас что то подгрузится"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        
        label.text = titleDefault
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var planetLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 2
        label.textColor = .black
        
        label.text = "..."
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
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
        view.addSubview(planetLabel)
        view.addSubview(button)
        
        dataRepository = DataRepository(networkService: NetworkService())
        
        setupConstraint()
        getUserNetworkService()
        getPlanetNetworkService()
    }
    
    private func setupConstraint() {
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -12),
            titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 12),
            
            planetLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 12),
            planetLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -12),
            planetLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func getPlanetNetworkService(){
        
        dataRepository?.getPlanetData { [weak self] result in
            
            guard let self = self else { return }
            switch result {
            case .success(let planetData):
                
                DispatchQueue.main.async {
                    self.planetLabel.text = "Период обращения планеты \(planetData.name) вокруг своей звезды - \(planetData.orbitalPeriod)"
                }
                
            case .failure(let error):
                
                DispatchQueue.main.async {
                    print("Error: \(error.localizedDescription)")
                }
                
            }
            
        }
    }
    
    private func getUserNetworkService(){
        
        dataRepository?.gethUserData { [weak self] result in
            
            guard let self = self else { return }
            switch result {
            case .success(let title):
                
                DispatchQueue.main.async {
                    self.titleLabel.text = title
                }
                
            case .failure(let error):
                
                DispatchQueue.main.async {
                    print("Error: \(error.localizedDescription)")
                }
                
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
