//
//  Container.swift
//  Kolsa
//
//  Created by Vladimir Orlov on 19.06.2025.
//

import Foundation

final class Container {
    // Костыль для возможности регистрировать зависимость с передачей аргумента
    private struct TypePairKey: Hashable {
        let serviceType: ObjectIdentifier
        let argumentType: ObjectIdentifier
        
        init(serviceType: Any.Type, argumentType: Any.Type) {
            self.serviceType = ObjectIdentifier(serviceType)
            self.argumentType = ObjectIdentifier(argumentType)
        }
    }
    
    private var services: [ObjectIdentifier: Any] = [:]
    private var servicesWithArgs: [TypePairKey: Any] = [:]
    
    func register<Service>(
        _ type: Service.Type,
        service: @escaping (Container) throws -> Service
    ) {
        services[ObjectIdentifier(type)] = service
    }
    
    func register<Service, Argument>(
        _ serviceType: Service.Type,
        factory: @escaping (Container, Argument) throws -> Service
    ) {
        let key = TypePairKey(serviceType: serviceType, argumentType: Argument.self)
        servicesWithArgs[key] = factory
    }
    
    func resolve<Service>(_ type: Service.Type) -> Service {
        let key = ObjectIdentifier(type)
        
        guard let service = services[key] as? (Container) throws -> Service else {
            fatalError("No registration found for type: \(type)")
        }
        
        do {
            return try service(self)
        } catch {
            fatalError("Failed to resolve \(type): \(error)")
        }
    }
    
    func resolve<Service, Argument>(_ type: Service.Type, argument: Argument) -> Service {
        let key = TypePairKey(serviceType: type, argumentType: Argument.self)
        
        guard let service = servicesWithArgs[key] as? (Container, Argument) throws -> Service else {
            fatalError("No registration found for \(type) with argument \(Argument.self)")
        }
        
        do {
            return try service(self, argument)
        } catch {
            fatalError("Failed to resolve \(type) with argument \(Argument.self): \(error)")
        }
    }
}
