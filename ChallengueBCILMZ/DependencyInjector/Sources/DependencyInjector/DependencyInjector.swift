// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

/// Dependency injector
public struct DependencyInjector {
    
    private static var dependencyList: [String: Any] = [:]
    
    /// Retreive the class registered inside the dependency list
    /// - Returns: T: type of the dependency class
    public static func resolve<T>() -> T {
        guard let t = dependencyList[String(describing: T.self)] as? T else {
            fatalError("DI:: No provider register for type: \(T.self)")
        }
        return t
    }
    
    ///  Register the class inside the dependency list
    /// - Parameter dependency: class to add into dependency list
    public static func register<T>(dependency: T) {
        dependencyList[String(describing: T.self)] = dependency
    }
}

/// PeopertyWrapper to provide dependencies: register
@propertyWrapper public struct Provider<T> {
    
    
    // MARK: - Properties
    
    public var wrappedValue: T
    
    
    // MARK: - Lifecycle
    
    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
        DependencyInjector.register(dependency: wrappedValue)
        debugPrint("DI:: Provider ->", self.wrappedValue)
    }
}

/// PropertyWrapper to inject dependencies: resolve
@propertyWrapper public struct Inject<T> {
    
    
    // MARK: - Properties
    
    public var wrappedValue: T
    
    
    // MARK: - Lifecycle
    
    public init() {
        self.wrappedValue = DependencyInjector.resolve()
        debugPrint("DI:: Injected <-", self.wrappedValue)
    }
}
