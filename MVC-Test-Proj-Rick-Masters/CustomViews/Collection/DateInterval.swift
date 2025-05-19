//
//  DateInterval.swift
//  MVC-Test-Proj-Rick-Masters
//
//  Created by Ruslan Kozlov on 19.05.2025.
//

import Foundation


public struct DateInterval {
    var isSelected: Bool
    var typeView: TypeView

    public enum TypeView: String {
        case onDay = "По дням"
        case onWeek = "По неделям"
        case onMonth = "По месяцам"
        case day = "Сегодня"
        case week = "Неделя"
        case month = "Месяц"
        case allTime = "Все время"
    }
}
