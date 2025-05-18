//
//  VisitorsAndStatisticsDataMapper.swift
//  MVC-Test-Proj-Rick-Masters
//
//  Created by Ruslan Kozlov on 18.05.2025.
//

import Foundation

struct VisitorsAndStatisticsDataMapper {

    static func getPercentageManWomanOnIntervalWithAge(
        dateInterval: DateInterval.TypeView,
        visitorsAndStatistics: VisitorsAndStatistics?,
        ageRangeLabel: String
    ) -> TwoLinesView.Data {
        guard let visitorsAndStatistics else { return TwoLinesView.Data(manPercentage: 0, womanPercentage: 0)}

        let calendar = Calendar.current
        let now = Date()
        let currentDateComponents = calendar.dateComponents([.year, .month, .day], from: now)
        let today = calendar.date(from: currentDateComponents)!

        var startDate: Date
        let endDate = today

        switch dateInterval {
        case .day:
            startDate = today
        case .week:
            startDate = calendar.date(byAdding: .day, value: -6, to: today)!
        case .month:
            let monthStart = DateComponents(year: currentDateComponents.year, month: currentDateComponents.month, day: 1)
            startDate = calendar.date(from: monthStart)!
        case .allTime:
            startDate = calendar.date(from: DateComponents(year: 2000, month: 1, day: 1))!
        default:
            return TwoLinesView.Data(manPercentage: 0, womanPercentage: 0)
        }

        let startDateNumber = dateToNumber(startDate)
        let endDateNumber = dateToNumber(endDate)

        let viewStatistics = visitorsAndStatistics.statistics.filter { $0.type == .view }

        var userIdsInInterval: Set<Int> = []
        for stat in viewStatistics {
            let matchingDates = stat.dates.filter { date in
                return date >= startDateNumber && date <= endDateNumber
            }
            if !matchingDates.isEmpty {
                userIdsInInterval.insert(stat.user_id)
            }
        }

        let filteredVisitors = visitorsAndStatistics.visitors.filter { userIdsInInterval.contains($0.id) }

        let ageRange: ClosedRange<Int>
        switch ageRangeLabel {
        case "18-21":
            ageRange = 18...21
        case "22-25":
            ageRange = 22...25
        case "26-30":
            ageRange = 26...30
        case "31-35":
            ageRange = 31...35
        case "36-40":
            ageRange = 36...40
        case "40-50":
            ageRange = 40...50
        case ">50":
            ageRange = 51...Int.max
        default:
            return TwoLinesView.Data(manPercentage: 0, womanPercentage: 0)
        }

        let visitorsInRange = filteredVisitors.filter { ageRange.contains($0.age) }
        let totalCount = visitorsInRange.count
        let manCount = visitorsInRange.filter { $0.sex == .M }.count
        let womanCount = visitorsInRange.filter { $0.sex == .F }.count

        guard totalCount > 0 else {
            return TwoLinesView.Data(manPercentage: 0, womanPercentage: 0)
        }

        let manPercentage = CGFloat(manCount) / CGFloat(totalCount)
        let womanPercentage = CGFloat(womanCount) / CGFloat(totalCount)
        return TwoLinesView.Data(manPercentage: manPercentage, womanPercentage: womanPercentage)
    }


    static func getPercentageManWomanOnInterval(
        dateInterval: DateInterval.TypeView,
        visitorsAndStatistics: VisitorsAndStatistics
    ) -> (man: CGFloat, woman: CGFloat) {
        let calendar = Calendar.current
        let now = Date()
        let currentDateComponents = calendar.dateComponents([.year, .month, .day], from: now)
        let today = calendar.date(from: currentDateComponents)!

        var startDate: Date
        let endDate = today

        switch dateInterval {
        case .day:
            startDate = today
        case .week:
            startDate = calendar.date(byAdding: .day, value: -6, to: today)! // 7 дней назад
        case .month:
            let monthStart = DateComponents(year: currentDateComponents.year, month: currentDateComponents.month, day: 1)
            startDate = calendar.date(from: monthStart)!
        case .allTime:
            startDate = calendar.date(from: DateComponents(year: 2000, month: 1, day: 1))! // Произвольная ранняя дата
        default:
            return (man: 0.0, woman: 0.0)
        }

        let startDateNumber = dateToNumber(startDate)
        let endDateNumber = dateToNumber(endDate)

        let viewStatistics = visitorsAndStatistics.statistics.filter { $0.type == .view }

        var userIdsInInterval: Set<Int> = []
        for stat in viewStatistics {
            let matchingDates = stat.dates.filter { date in
                return date >= startDateNumber && date <= endDateNumber
            }
            if !matchingDates.isEmpty {
                userIdsInInterval.insert(stat.user_id)
            }
        }

        let filteredVisitors = visitorsAndStatistics.visitors.filter { userIdsInInterval.contains($0.id) }

        let totalCount = filteredVisitors.count
        let manCount = filteredVisitors.filter { $0.sex == .M }.count
        let womanCount = filteredVisitors.filter { $0.sex == .F }.count

        guard totalCount > 0 else {
            return (man: 0.0, woman: 0.0)
        }

        let manPercentage = CGFloat(manCount) / CGFloat(totalCount)
        let womanPercentage = CGFloat(womanCount) / CGFloat(totalCount)

        return (man: manPercentage, woman: womanPercentage)
    }

    private static func dateToNumber(_ date: Date) -> Int {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        return day * 1000000 + month * 10000 + year
    }
}
