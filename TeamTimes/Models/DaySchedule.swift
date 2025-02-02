import Foundation

struct DaySchedule {
    var status: WorkStatus?
    var startTime: Date
    var endTime: Date
    
    init(status: WorkStatus? = nil, startTime: Date = Calendar.current.date(from: DateComponents(hour: 9, minute: 0)) ?? Date(), 
         endTime: Date = Calendar.current.date(from: DateComponents(hour: 17, minute: 0)) ?? Date()) {
        self.status = status
        self.startTime = startTime
        self.endTime = endTime
    }
} 