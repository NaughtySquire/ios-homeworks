//
//  LogInFactory.swift
//  Netology_IOS_graduate_work
//
//  Created by Роман Олегович on 26.06.2022.
//

import Foundation

protocol LogInFactoryProtocol {
    func createLoInInspector() -> LogInInspector
}
/// Микропредприятие, создающее объекты LogInInspector
class LogInFactory: LogInFactoryProtocol{
    func createLoInInspector() -> LogInInspector {
        return LogInInspector()
    }
}
