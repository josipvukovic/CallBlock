import UIKit
import CallKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  class var shared: AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
  }
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    /*CXCallDirectoryManager.sharedInstance.reloadExtension(withIdentifier:
        "com.jv.callblock.CallBlockDirectory", completionHandler: { (error) -> Void in
            if let error = error {
                print(error.localizedDescription)
            }
    })*/
    
    return true
  }
  
}

