import Foundation

struct User: Identifiable {
    let id: UUID
    let name: String
    var weeklySchedule: [String: DaySchedule]
    
    init(name: String, weeklySchedule: [String: DaySchedule] = [:]) {
        self.id = UUID()
        self.name = name
        self.weeklySchedule = weeklySchedule
    }
} 