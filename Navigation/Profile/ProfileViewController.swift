import UIKit

class ProfileViewController: UIViewController {
    
    
    var profilePhotos: [ProfilePhoto] = ProfilePhoto.make() // массив фотографий
    
    
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
        
        view.addSubview(tableView)
        
        tuneTableView()
        setupContraints()
        
    }
    
    
    private func tuneTableView() {
        
//        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "photoCell")
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseIdentifier)
        
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "postCell")
        
        tableView.tintColor = .red
        
        
        tableView.rowHeight = UITableView.automaticDimension
        
        // Указываем основные делегаты таблицы
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupContraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
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
        let headerView = ProfileHeaderView()
        // Configure your headerView if needed
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200 // Set the appropriate height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            // Тап произошел на первой ячейке "Фото"
            let galleryVC = GalleryPhotosViewController()
            galleryVC.galleryPhotos = profilePhotos
            
            
            let backBtn = UIBarButtonItem()
            backBtn.title = "Назад"
            navigationController?.navigationItem.backBarButtonItem = backBtn
            
            navigationController?.pushViewController(galleryVC, animated: true)
        }
    }
}

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier, for: indexPath) as? TableViewCell else {
                assertionFailure("TableViewCell is nil")
                return UITableViewCell()
            }
            
            cell.update()
            
            return cell
        } else {
            // Это обычная ячейка для поста
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell else {
                fatalError("Не удалось создать ячейку")
            }
            
            let post = posts[indexPath.row - 1]
            cell.configure(with: post)
            
            return cell
        }
    }
    
}
