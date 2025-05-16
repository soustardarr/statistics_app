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
    case usersSub([UsersSubs])
    case frequentVisitors([FrequentVisitors])
}

struct FrequentVisitors {
    let visitors: [Visitor]
}

struct Visitor {
    let userName: String
    let id: Int
    let sex: Sex
    let age: Int
    let isOnline: Bool
    let files: [File]

    enum Sex: String {
        case M = "M"
        case F = "F"
    }

    enum CodingKeys: String, CodingKey {
        case userName = "username"
        case id
        case sex
        case age
        case isOnline
        case files
    }
}

struct File {
    let id: Int
    let url: String
    let type: TypeFile

    enum TypeFile: String {
        case avatar = "avatar"
    }
}


struct UsersSubs {
    let usersSub: UsersView
    let usersUn: UsersView
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
