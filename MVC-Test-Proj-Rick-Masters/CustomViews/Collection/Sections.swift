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

public struct VisitorsAndStatistics: Codable {
    public let visitors: [Visitor]
    public let statistics: [Statistics]
    
    public init(visitors: [Visitor], statistics: [Statistics]) {
        self.visitors = visitors
        self.statistics = statistics
    }
    
    public enum CodingKeys: String, CodingKey {
        case visitors = "users"
        case statistics
    }
}

public struct Visitor: Codable  {
    let userName: String
    let id: Int
    let sex: Sex
    let age: Int
    let isOnline: Bool
    let files: [File]

    enum Sex: String, Codable {
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

struct File: Codable  {
    let id: Int
    let url: String
    let type: TypeFile

    enum TypeFile: String, Codable {
        case avatar = "avatar"
    }
}


struct UsersSubs: Codable  {
    let usersSub: UsersView
    let usersUn: UsersView
}


struct UsersView: Codable  {
    var count: Int
    var type: UsersViewType
}

enum UsersViewType: Codable  {
    case subscription
    case unsubscription
    case view
}

//struct DateInterval {
//    var isSelected: Bool
//    var typeView: TypeView
//
//    enum TypeView: String {
//        case onDay = "По дням"
//        case onWeek = "По неделям"
//        case onMonth = "По месяцам"
//        case day = "Сегодня"
//        case week = "Неделя"
//        case month = "Месяц"
//        case allTime = "Все время"
//    }
//}

struct ArrayStatistics: Codable  {
    let statistics: [Statistics]
}

public struct Statistics: Codable {
    let user_id: Int
    let type: StatisticsType
    let dates: [Int]

    enum StatisticsType: String, Codable {
        case view = "view"
        case subscription = "subscription"
        case unsubscription = "unsubscription"
    }
}
