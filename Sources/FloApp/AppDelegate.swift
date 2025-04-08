/*
 𝗙𝗟𝗢 : 𝗗𝗶𝘀𝘁𝗿𝗶𝗯𝘂𝘁𝗲𝗱 𝗛𝗶𝗲𝗿𝗮𝗿𝗰𝗵𝗶𝗰𝗮𝗹 𝗗𝗮𝘁𝗮𝗳𝗹𝗼𝘄
 MIT License

 Copyright (c) 2025 kk-0129

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */
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
