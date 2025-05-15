//
//  Sections.swift
//  MVC-Test-Proj-Rick-Masters
//
//  Created by Ruslan Kozlov on 15.05.2025.
//

import Foundation

enum Sections {
    case usersView([UsersView])
    case dateIntervals([DateInterval])
    case genderIntervals([DateInterval])
}


struct UsersView {
    var count: Int
    var type: UsersViewType
}

enum UsersViewType {
    case subscription
    case unsubscription
    case view
}

struct DateInterval {
    var isSelected: Bool
    var typeView: TypeView

    enum TypeView: String {
        case onDay = "По дням"
        case onWeek = "По неделям"
        case onMonth = "По месяцам"
        case day = "Сегодня"
        case week = "Неделя"
        case month = "Месяц"
        case allTime = "Все время"
    }
}
