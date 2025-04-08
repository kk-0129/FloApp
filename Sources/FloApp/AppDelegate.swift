// 𝗙𝗟𝗢 : 𝗗𝗶𝘀𝘁𝗿𝗶𝗯𝘂𝘁𝗲𝗱 𝗛𝗶𝗲𝗿𝗮𝗿𝗰𝗵𝗶𝗰𝗮𝗹 𝗗𝗮𝘁𝗮𝗳𝗹𝗼𝘄 © 𝖪𝖾𝗏𝖾𝗇 𝖪𝖾𝖺𝗋𝗇𝖾𝗒 𝟮𝟬𝟮𝟯
import AppKit
import Flo2D
import FloGraph
import FloBox

open class AppDelegate: NSObject, NSApplicationDelegate {
    
    open func startup(_ hub:Hub){
        // override this method to add filters to the hub
    }
    
    open func takedown(_ hub:Hub){
        // override this method to add filters to the hub
    }
    
    public func applicationWillFinishLaunching(_ notification: Notification) {
        startup(SHARED_FLO_HUB)
        Color.picker = MyColorPicker()
        Scene2D.pasteboard = THE_PASTEBOARD
    }
    
    open func applicationDidFinishLaunching(_ aNotification: Notification) {
        //
    }

    public func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        takedown(SHARED_FLO_HUB)
    }

    public func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    @IBAction func toggleDebugParser(_ s:NSButton?){
        FloGraph.___debug_parser___ = (s?.state == .on)
    }
    
    @IBAction func toggleLog(_ s:NSButton?){
        __log__.on = (s?.state == .on)
    }

}
