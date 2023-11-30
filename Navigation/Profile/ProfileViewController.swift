import UIKit
import SnapKit

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
    
    var user: User?
    
    var profilePhotos: [ProfilePhoto] = ProfilePhoto.make() // массив фотографий
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(
            frame: .zero,
            style: .grouped
        )
//        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // что бы увидеть что цвет фона зависит от выбранной схемы
        // пришлось изменить один констрейн в методе setupContraints

//        #if DEBUG
//        view.backgroundColor = .systemRed
//        #else
//        view.backgroundColor = .systemBlue
//        #endif

        
        view.addSubview(tableView)
        
        tuneTableView()
        setupContraints()
        
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
//        NSLayoutConstraint.activate([
////            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            tableView.topAnchor.constraint(equalTo: view.topAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//        ])
        
        tableView.snp.makeConstraints { (make) -> Void in
            
            make.height.equalTo(self.view)
            make.leading.equalTo(self.view)
            make.trailing.equalTo(self.view)
            
        }
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
        
        if let user = user {
            headerView.configure(with: user)
        }

        headerView.profileVC = self
      
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            
            let galleryVC = GalleryViewController()
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
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as? PhotosTableViewCell else {
                fatalError("Не удалось создать ячейку")
            }
            
            cell.photos = profilePhotos
            
            return cell
        } else {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell else {
                fatalError("Не удалось создать ячейку")
            }
            
            let post = posts[indexPath.row - 1]
            cell.configure(with: post)
            
            return cell
        }
    }
    
}
