//
//  SceneDelegate.swift
//  FinanceManager
//
//  Created by Dima on 23.05.22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        CoreDataManager.instance.loadContext()
        guard let windowScene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController()
        let rootVC = window?.rootViewController as! UINavigationController
        rootVC.setNavigationBarHidden(true, animated: false)
        rootVC.pushViewController(setInitialController(), animated: true)
        window?.makeKeyAndVisible()
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let rootVC = window?.rootViewController as! UINavigationController
        rootVC.popToRootViewController(animated: false)
        if let _ = UserDataManager.data.password{
            if SettingsManager.settings.password == true{
                let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
                rootVC.pushViewController(vc, animated: true)
            }else{
                let vc = storyboard.instantiateViewController(withIdentifier: "AccountViewController")
                rootVC.pushViewController(vc, animated: true)
            }
        }
        else{
            let vc = storyboard.instantiateViewController(withIdentifier: "SignUpViewController")
            rootVC.pushViewController(vc, animated: true)
        }
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        CoreDataManager.instance.saveContext()
    }
    
    private func setInitialController() -> UIViewController{
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let _ = UserDataManager.data.password{
            if SettingsManager.settings.password == true{
                let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
                return vc
            }else{
                let vc = storyboard.instantiateViewController(withIdentifier: "AccountViewController")
                return vc
            }
        }
        let vc = storyboard.instantiateViewController(withIdentifier: "SignUpViewController")
        return vc
    }
}

