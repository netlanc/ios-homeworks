import UIKit

protocol profileVCDelegate: AnyObject {
    func scrrollStop()
    func scrrollRun()
}

extension ProfileViewController: profileVCDelegate {
    
    func scrrollStop() {
        self.tableView.isScrollEnabled = false
        self.tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.isUserInteractionEnabled = false
    }
    
    func scrrollRun() {
        self.tableView.isScrollEnabled = true
        self.tableView.cellForRow(at: IndexPath(row: 0, section: 0))?.isUserInteractionEnabled = true
        
    }
}


class ProfileViewController: UIViewController {
    
    private let coreDataService = CoreDataService.shared
    
    private var viewModel: ProfileViewModel
    
    var headerProfile = ProfileHeaderView()
    
    var user: User?
    
    var profilePhotos: [ProfilePhoto] = ProfilePhoto.make() // массив фотографий
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(
            frame: .zero,
            style: .grouped
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    
    // MARK: - Init
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // что бы увидеть что цвет фона зависит от выбранной схемы
        // пришлось изменить один констрейн в методе setupContraints
//#if DEBUG // Схема - Navigation
//        view.backgroundColor = .systemRed
//#else
        view.backgroundColor = .systemBackground
//#endif
        
        view.addSubview(tableView)
        
        tuneTableView()
        setupContraints()
        
        bindViewModel()
        
    }
    
    private func bindViewModel() {
        viewModel.currentState = { [weak self] state in
            guard let self else { return }
            switch state {
            case .initial:
                print("initial")
            case .loading:
                
                headerProfile.activityIndicator.isHidden = false
                
            case .loaded(let user):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.user = user
                    headerProfile.activityIndicator.isHidden = true
                    tableView.reloadData()
                    
                    print("loaded loaded")
                    
                }
            case .error:
                print("error")
            }
        }
    }
    private func tuneTableView() {
        
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "photoCell")
        
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "postCell")
        
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupContraints() {
        
        // пришлось изменить один констрейн что бы был виде фон в зависимости от выбранной схемы
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            //            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if let user = user {
            headerProfile.configure(with: user)
        }
        
        headerProfile.profileVC = self
        
        return headerProfile
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            viewModel.showGallery?()
        } else {
            let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
            doubleTapGesture.numberOfTapsRequired = 2
            
            guard let cell = tableView.cellForRow(at: indexPath) as? PostTableViewCell else { return }
            cell.contentView.addGestureRecognizer(doubleTapGesture)
        }
    }
    
    // Метод для обработки двойного тапа
    @objc func handleDoubleTap(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == .recognized {
            // Получаем точку касания
            let touchPoint = recognizer.location(in: tableView)
            
            // Получаем индекс ячейки, над которой произошел тап
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                // Получаем индекс поста
                let index = indexPath.row - 1
                
                var isLiked = true
                
                // Проверяем, есть ли индекс уже в CoreData
                if coreDataService.containsLikedPostIndex(index) {
                    // Если есть, удаляем его
                    isLiked = false
                    coreDataService.deleteLikedPostIndex(index)
                } else {
                    // Если нет, добавляем
                    coreDataService.saveLikedPostIndex(index)
                }
                
                // Выводим индекс поста в консоль
                print("Double tapped post at index:", index)
                
                // Показываем анимацию сердечка
                showHeartAnimation(at: indexPath, isLiked: isLiked)
            }
        }
    }
    
    // Метод для отображения анимации сердечка по центру ячейки
    private func showHeartAnimation(at indexPath: IndexPath, isLiked: Bool) {
        
        let systemNameImage = !isLiked ? "heart" : "heart.fill"
        
        let heartImageView = UIImageView(image: UIImage(systemName: systemNameImage))
        heartImageView.tintColor = !isLiked ? .systemGray : .systemRed
        heartImageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        heartImageView.center = tableView.cellForRow(at: indexPath)?.center ?? view.center
        heartImageView.alpha = 0
        
        tableView.addSubview(heartImageView)
        
        // Анимация появления сердечка
        UIView.animate(withDuration: 0.5) {
            heartImageView.alpha = 1
        } completion: { _ in
            // Задержка перед исчезновением
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                // Анимация исчезновения сердечка
                UIView.animate(withDuration: 0.5) {
                    heartImageView.alpha = 0
                } completion: { _ in
                    heartImageView.removeFromSuperview()
                }
            }
        }
    }
    
}

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as? PhotosTableViewCell else {
                fatalError(NSLocalizedString("sys.error.create-cell", comment: "Не удалось создать ячейку"))
            }
            
            cell.photos = profilePhotos
            
            return cell
            
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell else {
                fatalError(NSLocalizedString("sys.error.create-cell", comment: "Не удалось создать ячейку"))
            }
            
            let post = posts[indexPath.row - 1]
            cell.configure(with: post)
            
            return cell
        }
    }
    
}
