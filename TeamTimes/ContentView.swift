//
//  ContentView.swift
//  TeamTimes
//
//  Created by moritzseyda on 02.02.25.
//

import SwiftUI

struct ContentView: View {
    @State private var schedules: [String: DaySchedule] = [:]
    private var weekDays: [(name: String, date: Date)] {
        let calendar = Calendar.current
        let today = Date()
        let weekday = calendar.component(.weekday, from: today)
        let daysUntilNextMonday = (9 - weekday) % 7
        let nextMonday = calendar.date(byAdding: .day, value: daysUntilNextMonday, to: today)!
        
        return (0..<5).compactMap { offset in
            guard let date = calendar.date(byAdding: .day, value: offset, to: nextMonday) else { return nil }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "E, MMM d"
            let dayName = dateFormatter.string(from: date)
            return (name: dayName, date: date)
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 15) {
                        ForEach(weekDays, id: \.date) { day in
                            DayRowView(
                                day: day.name,
                                schedule: scheduleBinding(for: day.name)
                            )
                        }
                    }
                    .padding()
                    
                    NavigationLink(destination: UserListView()) {
                        Text("View All User Schedules")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Weekly Schedule")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func scheduleBinding(for day: String) -> Binding<DaySchedule?> {
        Binding(
            get: { schedules[day] },
            set: { schedules[day] = $0 }
        )
    }
}

#Preview {
    ContentView()
}
