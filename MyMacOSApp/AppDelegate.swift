//
//  AppDelegate.swift
//  MyMacOSApp
//
//  Created by steve.ham on 2020/12/19.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    private let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    // Info.plist Application is agent: YES -> Set no app from dock
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem.button?.title = "MyMacOSApp"
        statusItem.menu = NSMenu()
        let menuItem = NSMenuItem(title: "Show Popover", action: #selector(clickShowPopover), keyEquivalent: "")
        statusItem.menu?.addItem(menuItem)
        
        let quitItem = NSMenuItem(title: "Quit", action: #selector(clickQuit), keyEquivalent: "")
        statusItem.menu?.addItem(quitItem)
    }
    
    @objc private func clickShowPopover(_ menuItem: NSMenuItem) {
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        guard let vc = storyboard.instantiateController(withIdentifier: "StatusBarVC") as? StatusBarVC else { return }
        let popoverView = NSPopover()
        popoverView.contentViewController = vc
        popoverView.behavior = .transient
        popoverView.show(relativeTo: statusItem.button!.bounds, of: statusItem.button!, preferredEdge: .maxY)
    }
    
    @objc private func clickQuit(_ menuItem: NSMenuItem) {
        NSApp.terminate(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "MyMacOSApp")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            container.viewContext.undoManager = UndoManager()
            if let error = error {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error)")
            }
        })
        return container
    }()
}
