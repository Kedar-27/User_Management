//
//  MVVMHelper.swift
//  User-Management
//
//  Created by Kedar Sukerkar on 21/09/20.
//  Copyright © 2020 Kedar Sukerkar. All rights reserved.
//

import Foundation

typealias CompletionHandler = (() -> Void)
class DynamicValue<T> {

    var value : T {
        didSet {
            self.notify()
        }
    }

    private var observers = [String: CompletionHandler]()

    init(_ value: T) {
        self.value = value
    }

    public func addObserver(_ observer: NSObject, completionHandler: @escaping CompletionHandler) {
        observers[observer.description] = completionHandler
    }

    public func addAndNotify(observer: NSObject, completionHandler: @escaping CompletionHandler) {
        self.addObserver(observer, completionHandler: completionHandler)
        self.notify()
    }

    private func notify() {
        observers.forEach({ $0.value()})
    }

    deinit {
        observers.removeAll()
    }
}
