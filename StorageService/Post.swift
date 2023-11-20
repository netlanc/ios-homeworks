
public struct Post {
    
    public let author: String
    public let title: String
    public let description: String
    public let image: String
    public let likes: Int
    public let views: Int
    
    public init(author: String, title: String, description: String, image: String, likes: Int, views: Int) {
        self.author = author
        self.title = title
        self.description = description
        self.image = image
        self.likes = likes
        self.views = views
    }
    
}
