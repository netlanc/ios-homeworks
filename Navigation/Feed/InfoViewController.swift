import UIKit

class InfoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(type: .system)
        button.setTitle("Нажми", for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
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
