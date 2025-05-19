//
//  NetworkService.swift
//  BusinessLogicFramework
//
//  Created by Ruslan Kozlov on 18.05.2025.
//

import Foundation
import RxSwift
import RxCocoa

public class NetworkService {
    private let session: URLSession
    private let disposeBag = DisposeBag()

    public init(session: URLSession = .shared) {
        self.session = session
    }

    private let statisticsURL = URL(string: "http://test.rikmasters.ru/api/statistics/")!
    private let usersURL = URL(string: "http://test.rikmasters.ru/api/users/")!

    private struct StatisticsResponse: Codable {
        let statistics: [BusinessLogicFramework.Statistics]
    }

    private struct UsersResponse: Codable {
        let users: [BusinessLogicFramework.Visitor]
    }

    public func fetchStatistics() -> Observable<[BusinessLogicFramework.Statistics]> {
        return Observable.create { observer in
            let task = self.session.dataTask(with: self.statisticsURL) { data, response, error in
                if let error = error {
                    print("Fetch Statistics Error: \(error.localizedDescription)")
                    observer.onError(error)
                    return
                }
                guard let data = data else {
                    print("Fetch Statistics Error: No data received")
                    observer.onError(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                    return
                }
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Statistics JSON Response: \(jsonString)")
                } else {
                    print("Fetch Statistics Error: Could not convert data to string")
                }
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(StatisticsResponse.self, from: data)
                    observer.onNext(response.statistics)
                    observer.onCompleted()
                } catch {
                    print("Fetch Statistics Decoding Error: \(error.localizedDescription)")
                    observer.onError(error)
                }
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }

    public func fetchUsers() -> Observable<[BusinessLogicFramework.Visitor]> {
        return Observable.create { observer in
            let task = self.session.dataTask(with: self.usersURL) { data, response, error in
                if let error = error {
                    print("Fetch Users Error: \(error.localizedDescription)")
                    observer.onError(error)
                    return
                }
                guard let data = data else {
                    print("Fetch Users Error: No data received")
                    observer.onError(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"]))
                    return
                }
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Users JSON Response: \(jsonString)")
                } else {
                    print("Fetch Users Error: Could not convert data to string")
                }
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(UsersResponse.self, from: data)
                    observer.onNext(response.users)
                    observer.onCompleted()
                } catch {
                    print("Fetch Users Decoding Error: \(error.localizedDescription)")
                    observer.onError(error)
                }
            }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }

    public func fetchAllData() -> Observable<BusinessLogicFramework.VisitorsAndStatistics> {
        return Observable.zip(fetchStatistics(), fetchUsers()) { stats, users in
            return BusinessLogicFramework.VisitorsAndStatistics(
                visitors: users,
                statistics: stats
            )
        }
        .catch { error in
            print("Error fetching data: \(error.localizedDescription)")
            return Observable.empty()
        }
    }
}
