import SwiftData

struct TMDBAPIObject: Decodable {
    var results: [Title] = []
}

@Model
class Title: Decodable, Identifiable, Hashable {
    @Attribute(.unique) var id: Int
    var title: String?
    var name: String?
    var overview: String?
    var posterPath: String?

    
    init(id: Int, title: String? = nil, name: String? = nil, overview: String? = nil, posterPath: String? = nil) {
        self.id = id
        self.title = title
        self.name = name
        self.overview = overview
        self.posterPath = posterPath
    }
    
    enum CodingKeys : CodingKey {
         case id
         case title
         case name
         case overview
         case posterPath
    }
    
    required init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)!
            title = try container.decodeIfPresent(String.self, forKey: .title)
            name = try container.decodeIfPresent(String.self, forKey: .name)
            overview = try container.decodeIfPresent(String.self, forKey: .overview)
            posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        }
    
    static var previewTitles = [
        Title(
            id: 1,
            title: "BeetleJuice",
            name: "BeetleJuice",
            overview: "A movie about BeetleJuice",
            posterPath: Constant.testTitleURL
            
        ),
        Title(
            id: 2,
            title: "Pulp Fiction",
            name: "Pulp Fiction",
            overview: "A movie about Pulp Fiction",
            posterPath: Constant.testTitleURL2
        ),
        Title(
            id: 3,
            title: "The Dark Knight",
            name: "The Dark Knight",
            overview: "A movie about the Dark Knight",
            posterPath: Constant.testTitleURL3
        ),
        Title(
            id: 4,
            title: "BeetleJuice",
            name: "BeetleJuice",
            overview: "A movie about BeetleJuice",
            posterPath: Constant.testTitleURL
            
        ),
        Title(
            id: 5,
            title: "Pulp Fiction",
            name: "Pulp Fiction",
            overview: "A movie about Pulp Fiction",
            posterPath: Constant.testTitleURL2
        ),
        Title(
            id: 6,
            title: "The Dark Knight",
            name: "The Dark Knight",
            overview: "A movie about the Dark Knight",
            posterPath: Constant.testTitleURL3
        ),
        Title(
            id: 7,
            title: "BeetleJuice",
            name: "BeetleJuice",
            overview: "A movie about BeetleJuice",
            posterPath: Constant.testTitleURL
            
        ),
        Title(
            id: 8,
            title: "Pulp Fiction",
            name: "Pulp Fiction",
            overview: "A movie about Pulp Fiction",
            posterPath: Constant.testTitleURL2
        ),
        Title(
            id: 9,
            title: "The Dark Knight",
            name: "The Dark Knight",
            overview: "A movie about the Dark Knight",
            posterPath: Constant.testTitleURL3
        ),
        Title(
            id: 10,
            title: "The Dark Knight",
            name: "The Dark Knight",
            overview: "A movie about the Dark Knight",
            posterPath: Constant.testTitleURL3
        ),
        Title(
            id: 11,
            title: "The Dark Knight",
            name: "The Dark Knight",
            overview: "A movie about the Dark Knight",
            posterPath: Constant.testTitleURL3
        ),
        Title(
            id: 12,
            title: "The Dark Knight",
            name: "The Dark Knight",
            overview: "A movie about the Dark Knight",
            posterPath: Constant.testTitleURL3
        ),
        Title(
            id: 13,
            title: "The Dark Knight",
            name: "The Dark Knight",
            overview: "A movie about the Dark Knight",
            posterPath: Constant.testTitleURL3
        ),
        Title(
            id: 14,
            title: "The Dark Knight",
            name: "The Dark Knight",
            overview: "A movie about the Dark Knight",
            posterPath: Constant.testTitleURL3
        ),
        Title(
            id: 15,
            title: "The Dark Knight",
            name: "The Dark Knight",
            overview: "A movie about the Dark Knight",
            posterPath: Constant.testTitleURL3
        ),
        Title(
            id: 16,
            title: "The Dark Knight",
            name: "The Dark Knight",
            overview: "A movie about the Dark Knight",
            posterPath: Constant.testTitleURL3
        ),
        Title(
            id: 17,
            title: "The Dark Knight",
            name: "The Dark Knight",
            overview: "A movie about the Dark Knight",
            posterPath: Constant.testTitleURL3
        ),
        Title(
            id: 18,
            title: "The Dark Knight",
            name: "The Dark Knight",
            overview: "A movie about the Dark Knight",
            posterPath: Constant.testTitleURL3
        )
    ]
}
