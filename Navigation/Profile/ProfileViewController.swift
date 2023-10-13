import UIKit

class ProfileViewController: UIViewController {
    
    private var posts: [Post] = [
        Post(
            author: "Bit.Fly",
            title: "Какие факторы будут толкать цену Биткоина вверх в 2023-2024г.",
            description: "Биткоин вновь затаился в “боковой” ценовой динамике, и вновь криптоаналитические порталы спорят до хрипоты, куда дальше двинется главная криптовалюта-штурман. Bitcoin – наряду с другими основными криптовалютами, Ethereum и Ripple (XRP) – явно потерял ценовой импульс после стремительного роста в начале 2023 года. Цена Биткоина потеряла около 60% с момента достижения пика почти в $70 000 в конце 2021 г., стерев около 2 трлн долл. совокупной рыночной капитализации трёх криптовалют.",
            image: "image1",
            likes: 10,
            views: 100
        ),
        Post(
            author: "JaneSmith",
            title: "🏆 Началось голосование за премию Blockchain Life Awards 2023!",
            description: "Компания UMINERS не только примет участие в форуме Blockchain Life 2023 в Дубае в качестве генерального спонсора, но и традиционно поборется за звание «Майнинг-дистрибьютор года».\n\n✔️Голосование уже началось!\n\n🤗 Мы искренне рассчитываем на поддержку наших клиентов и подписчиков!",
            image: "image2",
            likes: 15,
            views: 200
        ),
        Post(
            author: "MarkJohnson", 
            title: "Фильм: Деньги с открытым исходным кодом",
            description: "Жанр: документалистика\nСтрана: США\nРейтинг IMDb: 8.8/10\nГод производства: 2020\nКинопродюсер и режиссёр: Дж.Д. Серафин\n\n«Деньги с открытым исходным кодом» – криптосериал, премьера которого состоялась в июле 2020 года. В нём рассказывается об одном из ведущих американских блокчейн-технологов, а также о развитии криптовалют и препятствиях, с которыми сталкиваются блокчейн-технологии в США.",
            image: "image3",
            likes: 20,
            views: 150
        ),
        Post(
            author: "SarahWilson",
            title: "🏠 На Московской бирже в 2024 году планируют выпускать ЦФА на жиль",
            description: "⚡️Если в Африке за Биткоин можно купить курицу, то почему в России за ЦФА, в конце концов, нельзя приобрести жильё!\n\n💲Планируется, что инструмент будет иметь вид денежных требований к эмитенту, и привязан к квадратным метрам.",
            image: "image4",
            likes: 5,
            views: 50
        )
    ]
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(
            frame: .zero,
            style: .plain
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
        
        // что бы header скролился вместе с постами? добавляем его тут
        let headerView = ProfileHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200))
        tableView.tableHeaderView = headerView
        
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "postCell")
        
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
    
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = ProfileHeaderView()
//        // Configure your headerView if needed
//        return headerView
//    }
//    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 200 // Set the appropriate height
//    }
}

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
        let post = posts[indexPath.row]
        cell.configure(with: post)
        
        return cell
    }
}
