import UIKit
//import FirebaseCore
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        
        window = UIWindow(windowScene: windowScene)
        
        let profileModel = ProfileViewModel.shared
        let mainCoordinator = MainCoordinator(profileModel: profileModel)
        
        window?.rootViewController = mainCoordinator.start()
        
        window?.makeKeyAndVisible()
        
    
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        try? Auth.auth().signOut()
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}
