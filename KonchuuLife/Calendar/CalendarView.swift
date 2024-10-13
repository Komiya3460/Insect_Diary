//
//  CalendarView.swift
//  KonchuuLife
//
//  Created by 越智三四郎 on 2024/10/02.
//
import SwiftUI
import FSCalendar
import Foundation

class CalendarCoordinator: NSObject, FSCalendarDelegate {
    
    let calendar: Calendar
    let targetMonth: Date

    init(calendar: Calendar, targetMonth: Date) {
        self.calendar = calendar
        self.targetMonth = targetMonth
    }
}

struct CalendarView: UIViewRepresentable {
    
    @Binding var currentPage: Date
    @Binding var currentScope: FSCalendarScope
    let calendarHeight: CGFloat

    func makeCoordinator() -> CalendarCoordinator {
        return CalendarCoordinator(calendar: Calendar.current, targetMonth: currentPage)
    }

    func makeUIView(context: Context) -> FSCalendar {
        let fsCalendar = FSCalendar()
        fsCalendar.delegate = context.coordinator
        fsCalendar.scope = currentScope
        fsCalendar.headerHeight = 0
        fsCalendar.placeholderType = .fillHeadTail
        fsCalendar.appearance.headerTitleColor = .black
        fsCalendar.appearance.weekdayTextColor = .black
        fsCalendar.appearance.headerMinimumDissolvedAlpha = 0
        fsCalendar.appearance.selectionColor = .blue
        fsCalendar.appearance.todayColor = .blue
        fsCalendar.translatesAutoresizingMaskIntoConstraints = false
        fsCalendar.heightAnchor.constraint(equalToConstant: calendarHeight).isActive = true
        return fsCalendar
    }
    func updateUIView(_ uiView: FSCalendar, context: Context) {
        uiView.setCurrentPage(currentPage, animated: true)
        uiView.scope = currentScope
    }
}

struct CalendarContentView: View {
    @State private var currentPage = Date()
    @State private var currentScope: FSCalendarScope = .month
    @State private var switchDateText = "Week"
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    moveCurrentPage(by: -1)
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18))
                        .foregroundColor(.black)
                }
                
                Text(currentMonthString())
                    .foregroundColor(.black)
                         
                Spacer()
                Button(action: {
                    switchDate()
                }) {
                    Text(switchDateText)
                                       .foregroundColor(.blue)
                                       .padding(10)
                                       .frame(width: 65)
                                       .frame(height: 25)
                                       .font(.system(size: 15, weight: .regular, design: .default))
                                       .overlay(
                                           RoundedRectangle(cornerRadius: 15)
                                               .stroke(Color.black, lineWidth: 1)
                                       )
                }
                .padding(.trailing, 10)
                Button(action: {
                    moveCurrentPage(by: 1)
                }) {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 18))
                        .foregroundColor(.black)
                    
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            
            CalendarView(currentPage: $currentPage, currentScope: $currentScope, calendarHeight: 400)
                .frame(height: 300)
                .padding(.top, 5)
                .padding(.horizontal, 10)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Color.white)
    }
    private func moveCurrentPage(by months: Int) {
        if let newPage = Calendar.current.date(byAdding: .month, value: months, to: currentPage) {
            currentPage = newPage
        }
    }
    private func currentMonthString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: currentPage)
    }
    private func switchDate() {
        switch currentScope {
        case .month:
            currentScope = .week
            switchDateText = "Month"
        case .week:
            currentScope = .month
            switchDateText = "Week"
        }
    }
}

#Preview {
    CalendarContentView()
}
