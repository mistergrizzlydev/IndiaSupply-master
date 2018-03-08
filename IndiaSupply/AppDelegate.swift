//
//  AppDelegate.swift
//  IndiaSupply
//
//  Created by Kamal rastogi on 9/26/17.
//  Copyright © 2017 Samarjeet. All rights reserved.
//

import UIKit
import Siren
import UserNotifications
import Firebase
import FirebaseInstanceID
import FirebaseMessaging
import FirebaseDynamicLinks


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate , UNUserNotificationCenterDelegate, MessagingDelegate {
 
    let customURLScheme = "dlscheme"
     var window: UIWindow?
   
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
        
         if (UserDefaults.standard.object(forKey: "loginkey") == nil)
        {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "SliderView") as! GetStarted
            
            self.window?.rootViewController = viewController
            self.window?.makeKeyAndVisible()
        }
        
        let siren = Siren.shared
        siren.delegate = self
        siren.alertType = .none
        siren.alertType = .option
        siren.showAlertAfterCurrentVersionHasBeenReleasedForDays = 1
        siren.checkVersion(checkType: .immediately)

        if #available(iOS 10.0, *) {
          
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            
            Messaging.messaging().delegate = self
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        FirebaseApp.configure()
        FirebaseOptions.defaultOptions()?.deepLinkURLScheme = self.customURLScheme
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {

    }


    func applicationWillEnterForeground(_ application: UIApplication) {
        Siren.shared.checkVersion(checkType: .immediately)
    
    }

    func applicationWillTerminate(_ application: UIApplication) {
  
    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }
    func applicationDidBecomeActive(_ application: UIApplication) {
   
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func application(received remoteMessage: MessagingRemoteMessage) {
        
    }
    
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
      
    }
  
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        return application(app, open: url,
                           sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                           annotation: "")
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if let dynamicLink = DynamicLinks.dynamicLinks()?.dynamicLink(fromCustomSchemeURL: url) {
            // Handle the deep link. For example, show the deep-linked content or
            // apply a promotional offer to the user's account.
            // [START_EXCLUDE]
            // In this sample, we just open an alert.
            handleDynamicLink(dynamicLink)
            // [END_EXCLUDE]
            return true
        }
        // [START_EXCLUDE silent]
        // Show the deep link that the app was called with.
        showDeepLinkAlertView(withMessage: "openURL:\n\(url)")
        // [END_EXCLUDE]
        return false
    }
    // [END openurl]
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        if let incomingURL = userActivity.webpageURL {
            let handleLink = DynamicLinks.dynamicLinks()?.handleUniversalLink(incomingURL, completion: { (dynamicLink, error) in
                if let dynamicLink = dynamicLink, let _ = dynamicLink.url
                {
                    print("Your Dynamic Link parameter: \(dynamicLink)")
                    
                   
                    let path = dynamicLink.url?.path
                   
                    let dynamicString = path as! String
                    
                    let parts = dynamicString.components(separatedBy: "/")
                 
                    if( parts[1] == "event")
                    {
                        UserDefaults.standard.set(parts[2], forKey: "EventPreID")
                        
                        if self.window!.rootViewController as? UITabBarController != nil {
                            let tababarController = self.window!.rootViewController as! UITabBarController
                            tababarController.selectedIndex = 2
                            
                            
                        }
                    }
                    else
                    {}
                    
                } else {
                    // Check for errors
                }
            })
            return handleLink!
        }
        return false
    }
    
    func handleDynamicLink(_ dynamicLink: DynamicLink) {
        print("Your Dynamic Link parameterabc: \(dynamicLink)")
        
        let path = dynamicLink.url?.path
      
//        let dynamicString = path as! String
//        
//        let parts = dynamicString.components(separatedBy: "/")
//        
//        if( parts[1] == "event")
//        {
//            print(parts[1])
//            
//            print(parts[2])
//            UserDefaults.standard.set(parts[2], forKey: "EventPreID")
//            
//            if self.window!.rootViewController as? UITabBarController != nil {
//                let tababarController = self.window!.rootViewController as! UITabBarController
//                tababarController.selectedIndex = 2
//                
//                
//            }
//        }
//        else
//        {}
    }
    // [START continueuseractivity]
//    func application(_ application: UIApplication, continue userActivity: NSUserActivity,
//                     restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
//        guard let dynamicLinks = DynamicLinks.dynamicLinks() else {
//            return false
//        }
//
//
//        let handled = dynamicLinks.handleUniversalLink(userActivity.webpageURL!) { (dynamiclink, error) in
//            // [START_EXCLUDE]
//
//            print(dynamiclink!)
//
//
//        
//
//
//            // [END_EXCLUDE]
//        }
//
//        // [START_EXCLUDE silent]
//        if !handled {
//            // Show the deep link URL from userActivity.
//            let message = "continueUserActivity webPageURL:\n\(userActivity.webpageURL?.absoluteString ?? "")"
//            showDeepLinkAlertView(withMessage: message)
//        }
//        // [END_EXCLUDE]
//        return handled
//    }
    // [END continueuseractivity]
    
//    func handleDynamicLink(_ dynamicLink: DynamicLink) {
//        let matchConfidence: String
//        if dynamicLink.matchConfidence == .weak {
//            matchConfidence = "Weak"
//        } else {
//            matchConfidence = "Strong"
//        }
//        let message = "App URL: \(dynamicLink.url?.absoluteString ?? "")\n" +
//        "Match Confidence: \(matchConfidence)\nMinimum App Version: \(dynamicLink.minimumAppVersion ?? "")"
//    //    showDeepLinkAlertView(withMessage: message)
//    }
    
    func showDeepLinkAlertView(withMessage message: String) {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let alertController = UIAlertController(title: "Deep-link Data", message: message, preferredStyle: .alert)
        alertController.addAction(okAction)
        self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }}

extension AppDelegate: SirenDelegate {
  
    func sirenDidDetectNewVersionWithoutAlert(message: String) {
       
    }
}

