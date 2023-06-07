//
//  GameOfLifeApp.swift
//  Shared
//
//  Created by Lukas Pistrol on 07.12.21.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct GameOfLifeApp: App {
	
	@StateObject private var lifeModel: GOLModel = .init(with: 30)
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
	
    var body: some Scene {
        WindowGroup {
            
            LoginView()
//            ContentView()
//                .environmentObject(self.lifeModel)
			#if os(macOS)
				.frame(width: 900, height: 900)
			#endif
				.preferredColorScheme(.dark)
        }
    }
}
