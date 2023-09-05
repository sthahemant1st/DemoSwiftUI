//
//  TypeAlise.swift
//  DemoSwiftUI
//
//  Created by Hemant Shrestha on 05/09/2023.
//

import Foundation

typealias ResultApi<T: Decodable> = Result<T, Error>
typealias VoidFunction = () -> Void
