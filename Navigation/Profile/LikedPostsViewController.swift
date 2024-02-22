//
//  LikedPostsViewController.swift
//  Navigation
//
//  Created by netlanc on 22.02.2024.
//

import UIKit
import StorageService

class LikedPostsViewController:UIViewController {
    
    var profileViewModel: ProfileViewModel
    
    //    var likedPostIndexes: [Int]
    
    private var bAuth: Bool = false
    private var likedPosts: [Post] = []
    private let coreDataService = CoreDataService.shared // Инициализируем CoreDataService
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(
            frame: .zero,
            style: .grouped
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Понравившиеся посты"
        
        view.addSubview(tableView)
        
        tuneTableView()
        setupContraints()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        printLikedPostIndexes()
        loadController()
    }
    
    func loadController() {
        
        if case .loaded(_) = profileViewModel.state {
            self.bAuth = true
            
            tableView.reloadData()
        } else {
            print("No user loaded")
        }
    }
    
    // Метод для вывода всех индексов в LikedPostIndex
    private func printLikedPostIndexes() {
        let likedPostIndexes = coreDataService.getLikedPostIndexes()
        print("Liked Post Indexes:", likedPostIndexes)
    }
    
    
    init(profileViewModel: ProfileViewModel) {
        self.profileViewModel = profileViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func tuneTableView() {
        
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "postCell")
        
        
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
    
}

extension LikedPostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !bAuth {
            1
        } else {
            max(coreDataService.getLikedPostIndexes().count, 1)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if !bAuth {
            
            let cell = UITableViewCell()
            cell.textLabel?.text = "Нужно залогиниться"
            
            return cell
            
        } else {
            
            let likedPostIndexes = coreDataService.getLikedPostIndexes()
            
            if likedPostIndexes.count == 0 {
                
                let cell = UITableViewCell()
                cell.textLabel?.text = "Еще ничего не добавлено в понравившиеся"
                
                return cell
                
            } else {
                
                let postIndex = likedPostIndexes[indexPath.row]
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell else {
                    fatalError("Не удалось создать ячейку")
                }
                
                let post = posts[postIndex]
                cell.configure(with: post)
                
                return cell
            }
        }
        
        
    }
    
    
    
}

extension LikedPostsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if bAuth {
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
                
                let likedPostIndexes = coreDataService.getLikedPostIndexes()
                
                coreDataService.deleteLikedPostIndex(likedPostIndexes[indexPath.row])
                
                // Показываем анимацию сердечка
                showHeartAnimation(at: indexPath, isLiked: false)
            }
        }
    }
    
    // Метод для отображения анимации сердечка по центру ячейки
    private func showHeartAnimation(at indexPath: IndexPath, isLiked: Bool) {
        
        let systemNameImage = "heart"
        
        let heartImageView = UIImageView(image: UIImage(systemName: systemNameImage))
        heartImageView.tintColor = .gray
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
                    
                    self.tableView.reloadData()
                }
            }
        }
    }
    
}
