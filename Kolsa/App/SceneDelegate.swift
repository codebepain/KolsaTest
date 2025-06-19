//
//  SceneDelegate.swift
//  KolsaTest
//
//  Created by Vladimir Orlov on 18.06.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)

        let container = Container()
        let assembler = Assembler(container: container)
        assembler.apply(assembly: ProductsAssembly())
        let rootVC = ProductListModuleBuilder.build(container: container)
        
        let navigationController = UINavigationController(rootViewController: rootVC)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        self.window = window
    }
}
