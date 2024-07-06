//
//  Injected.swift
//  TheMovieDB
//
//  Created by alfian on 06/07/24.
//

import Foundation
import SwiftUI

@propertyWrapper struct Injected<Dependency> {
  let wrappedValue: Dependency

  init() {
    self.wrappedValue = Injection.shared.container.resolve(Dependency.self)!
  }
}

// MARK: reference -> https://stackoverflow.com/questions/64764290/is-it-possible-to-nest-property-wrappers-in-swift-when-using-observedobject
// We need to make sure InjectedObject implement ObservableObject
@propertyWrapper struct InjectedObject<Dependency>: DynamicProperty where Dependency: ObservableObject {
  @ObservedObject var wrappedValue: Dependency

  init() {
    self.wrappedValue = Injection.shared.container.resolve(Dependency.self)!
  }
}
