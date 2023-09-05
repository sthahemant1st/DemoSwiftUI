//
//  PaginationQuery.swift
//  DemoSwiftUI
//
//  Created by Hemant Shrestha on 05/09/2023.
//

import Foundation

struct PaginationQuery: Encodable {
    let offset: Int
    let limit: Int
}
