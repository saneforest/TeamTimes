import SwiftUI

struct DayRowView: View {
    let day: String
    @Binding var schedule: DaySchedule?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(day)
                .font(.headline)
            
            // Status Selection
            Menu {
                ForEach(WorkStatus.allCases, id: \.self) { status in
                    Button {
                        if schedule == nil {
                            schedule = DaySchedule(status: status)
                        } else {
                            schedule?.status = status
                        }
                    } label: {
                        Label(status.rawValue, systemImage: status.icon)
                    }
                }
            } label: {
                HStack {
                    Image(systemName: schedule?.status?.icon ?? "square.dashed")
                    Text(schedule?.status?.rawValue ?? "Select Status")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            }
            
            // Time Selection
            if schedule != nil {
                HStack {
                    DatePicker("Start", 
                             selection: Binding(
                                get: { schedule?.startTime ?? Date() },
                                set: { if schedule != nil { schedule?.startTime = $0 } }
                             ),
                             displayedComponents: .hourAndMinute)
                    
                    Text("-")
                    
                    DatePicker("End",
                             selection: Binding(
                                get: { schedule?.endTime ?? Date() },
                                set: { if schedule != nil { schedule?.endTime = $0 } }
                             ),
                             displayedComponents: .hourAndMinute)
                }
                .labelsHidden()
            }
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }
} 
