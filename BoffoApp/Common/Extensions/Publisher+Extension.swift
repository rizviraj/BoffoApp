//
//  Publisher+Extension.swift
//  BoffoApp
//
//  Created by MacBook Pro on 2024-11-23.
//

import Foundation
import Combine

extension Publisher where Failure == Never {

    func assignNoRetain<Root: AnyObject>(to keyPath: ReferenceWritableKeyPath<Root, Self.Output>,
                                         on object: Root) -> AnyCancellable {
        sink { [weak object] value in
            object?[keyPath: keyPath] = value
        }
    }

    func assignOptionalNoRetain<Root: AnyObject>(to keyPath: ReferenceWritableKeyPath<Root, Self.Output?>,
                                                 on object: Root) -> AnyCancellable {
        sink { [weak object] value in
            object?[keyPath: keyPath] = value
        }
    }

    func assign<S: Subject>(toSubject: S?) -> AnyCancellable where S.Output == Self.Output {
        self.sink { [weak toSubject] in
            toSubject?.send($0)
        }
    }

    func withLatestFrom<P>(_ other: P) -> AnyPublisher<(Self.Output, P.Output),
                                                        Failure> where P: Publisher,
                                                                        Self.Failure == P.Failure {
      let other = other
        // Note: Do not use `.map(Optional.some)` and `.prepend(nil)`.
        // There is a bug in iOS versions prior 14.5 in `.combineLatest`. If P.Output itself is Optional.
        // In this case prepended `Optional.some(nil)` will become just `nil` after `combineLatest`.
        .map { (value: $0, ()) }
        .prepend((value: nil, ()))

      return map { (value: $0, token: UUID()) }
        .combineLatest(other)
        .removeDuplicates(by: { (old, new) in
          let lhs = old.0, rhs = new.0
          return lhs.token == rhs.token
        })
        .map { ($0.value, $1.value) }
        .compactMap { (left, right) in
          right.map { (left, $0) }
        }
        .eraseToAnyPublisher()
    }
}

extension Publisher {
    // swiftlint:disable line_length
    func flatMap<A: AnyObject, P, T>(weak obj: A, _ transform: @escaping (A, Output) -> P) -> Publishers.FlatMap<AnyPublisher<T, Failure>, Self> where P: Publisher, P.Output == T, Failure == P.Failure {
            flatMap { [weak obj] value -> AnyPublisher<T, Failure>  in
                guard let obj = obj else { return Empty<T, Failure>().eraseToAnyPublisher() }
                return transform(obj, value).eraseToAnyPublisher()
            }
        }
}
