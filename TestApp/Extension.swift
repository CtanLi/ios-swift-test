//
//  Extension.swift
//  TestApp
//
//  Created by CtanLI on 2019-11-22.
//  Copyright © 2019 AlayaCare. All rights reserved.
//

import Foundation

extension Date {
    func formatTodaysDate() -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MMMM dd, YYYY"
        return dateFormat.string(from: Date())
    }
}

extension CodingUserInfoKey {
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}
