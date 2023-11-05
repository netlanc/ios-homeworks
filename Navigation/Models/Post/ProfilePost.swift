import UIKit

struct Post {
    let author: String
    let title: String
    let description: String
    let image: String
    let likes: Int
    let views: Int
}

var posts: [Post] = [
    Post(
        author: "Bit.Fly",
        title: "Какие факторы будут толкать цену Биткоина вверх в 2023-2024г.",
        description: "Биткоин вновь затаился в “боковой” ценовой динамике, и вновь криптоаналитические порталы спорят до хрипоты, куда дальше двинется главная криптовалюта-штурман. Bitcoin – наряду с другими основными криптовалютами, Ethereum и Ripple (XRP) – явно потерял ценовой импульс после стремительного роста в начале 2023 года. Цена Биткоина потеряла около 60% с момента достижения пика почти в $70 000 в конце 2021 г., стерев около 2 трлн долл. совокупной рыночной капитализации трёх криптовалют.",
        image: "Post",
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