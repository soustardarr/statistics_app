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
    case chartVisitorsCell([ArrayStatistics])
    case visitorsAndStatisticsCell([VisitorsAndStatistics])
}

struct FrequentVisitors: Decodable  {
    let visitors: [Visitor]
}

struct VisitorsAndStatistics: Decodable {
    let visitors: [Visitor]
    let statistics: [Statistics]
}

struct Visitor: Decodable  {
    let userName: String
    let id: Int
    let sex: Sex
    let age: Int
    let isOnline: Bool
    let files: [File]

    enum Sex: String, Decodable {
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

struct File: Decodable  {
    let id: Int
    let url: String
    let type: TypeFile

    enum TypeFile: String, Decodable {
        case avatar = "avatar"
    }
}


struct UsersSubs: Decodable  {
    let usersSub: UsersView
    let usersUn: UsersView
}


struct UsersView: Decodable  {
    var count: Int
    var type: UsersViewType
}

enum UsersViewType: Decodable  {
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

struct ArrayStatistics: Decodable  {
    let statistics: [Statistics]
}

struct Statistics: Codable {
    let user_id: Int
    let type: StatisticsType
    let dates: [Int]

    enum StatisticsType: String, Codable {
        case view = "view"
        case subscription = "subscription"
        case unsubscription = "unsubscription"
    }
}
