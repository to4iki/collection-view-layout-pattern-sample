struct DetailSectionModel {
    var provider: DetailSectionProvider
    var section: DetailSection
    var items: [DetailSectionItem]
}

enum DetailSection: Hashable {
    case main
    case purchase
    case description
    case feature(Int)
}

enum DetailSectionItem: Hashable {
    case main
    case purchase
    case description
    case feature(Item)
}
