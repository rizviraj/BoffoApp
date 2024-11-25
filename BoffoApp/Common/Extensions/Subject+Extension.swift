//
//  Subject+Extension.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import Combine

public typealias BAAnyPublisher<T> = AnyPublisher<T, Never>
public typealias BAPassthroughSubject<T> = PassthroughSubject<T, Never>
public typealias BACurrentValueSubject<T> = CurrentValueSubject<T, Never>
