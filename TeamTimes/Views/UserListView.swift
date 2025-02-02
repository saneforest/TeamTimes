import SwiftUI

struct UserListView: View {
    @State private var users: [User] = [
        User(name: "Alice", weeklySchedule: [
            "Mon, Feb 5": DaySchedule(status: .office),
            "Tue, Feb 6": DaySchedule(status: .remote),
            // Add more days as needed
        ]),
        User(name: "Bob", weeklySchedule: [
            "Mon, Feb 5": DaySchedule(status: .office), // Same status as Alice on Monday
            "Tue, Feb 6": DaySchedule(status: .university),
            // Add more days as needed
        ]),
        User(name: "Charlie", weeklySchedule: [
            "Mon, Feb 5": DaySchedule(status: .office), // Same status as Alice and Bob on Monday
            "Tue, Feb 6": DaySchedule(status: .remote),
            // Add more days as needed
        ])
        // Add more users as needed
    ]
    
    private var groupedUsersByDay: [String: [String: [User]]] {
        var grouped = [String: [String: [User]]]()
        
        for user in users {
            for (day, schedule) in user.weeklySchedule {
                if let status = schedule.status {
                    if grouped[day] == nil {
                        grouped[day] = [status.rawValue: [user]]
                    } else {
                        if grouped[day]?[status.rawValue] == nil {
                            grouped[day]?[status.rawValue] = [user]
                        } else {
                            grouped[day]?[status.rawValue]?.append(user)
                        }
                    }
                }
            }
        }
        
        return grouped
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(groupedUsersByDay.keys.sorted(), id: \.self) { day in
                    Section(header: Text(day)
                                .font(.title3)
                                .foregroundColor(.primary)
                                .padding(.vertical, 5)
                    ) {
                        if let statuses = groupedUsersByDay[day] {
                            ForEach(statuses.keys.sorted(), id: \.self) { status in
                                if let users = statuses[status] {
                                    VStack(alignment: .leading) {
                                        HStack {
                                            if let firstUser = users.first, let firstStatus = firstUser.weeklySchedule[day]?.status {
                                                Image(systemName: firstStatus.icon)
                                                    .foregroundColor(.accentColor)
                                            }
                                            Text(status)
                                                .font(.headline)
                                                .foregroundColor(.accentColor)
                                        }
                                        ForEach(users) { user in
                                            Text(user.name)
                                                .font(.body)
                                                .foregroundColor(.primary)
                                                .padding(.vertical, 2)
                                        }
                                    }
                                    .padding(.vertical, 5)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("User Schedules by Day")
        }
    }
}

#Preview {
    UserListView()
} 