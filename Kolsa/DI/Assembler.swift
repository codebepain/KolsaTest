//
//  Assembler.swift
//  Kolsa
//
//  Created by Vladimir Orlov on 19.06.2025.
//

import Foundation

final class Assembler {
    private let container: Container

    init(container: Container = Container()) {
        self.container = container
    }
    
    func apply(assembly: Assembly) {
        assembly.assemble(container: container)
    }
    
    func apply(assemblies: [Assembly]) {
        assemblies.forEach { $0.assemble(container: container) }
    }

    func resolve<Service>(_ type: Service.Type) -> Service {
        container.resolve(type)
    }

    func resolve<Service, Argument>(_ type: Service.Type, argument: Argument) -> Service {
        container.resolve(type, argument: argument)
    }
}
