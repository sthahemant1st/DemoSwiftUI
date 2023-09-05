//
//  Optional+Extension.swift
//  DemoSwiftUI
//
//  Created by Hemant Shrestha on 05/09/2023.
//

import Foundation

extension Optional {
    var isNil: Bool {
        return self == nil
    }

    var hasValue: Bool {
        return !isNil
    }
}
