enum WorkStatus: String, CaseIterable {
    case office = "Office"
    case remote = "Remote"
    case vacation = "Vacation"
    case university = "University"
    
    var icon: String {
        switch self {
        case .office: return "building.2"
        case .remote: return "house"
        case .vacation: return "airplane"
        case .university: return "books.vertical"
        }
    }
} 