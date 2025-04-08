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
import Foundation
import Flo2D
import FloGraph
import FloBox
import Cocoa

public class MyColorPicker : NSObject, Flo2D.ColorPicker{
    
    public override init(){
        super.init()
        let cp = NSColorPanel.shared
        cp.setTarget(self)
        cp.setAction( #selector( colorPanelDidChange(_:) ) )
        cp.isContinuous = true
        cp.hidesOnDeactivate = true
        cp.disableSnapshotRestoration()
    }
    
    public var show = false{ didSet{ if show != oldValue{
        let cp = NSColorPanel.shared
        if show{ cp.orderFront(self) }
        else{ cp.close() }
    }}}
    
    public var callback : ((Color)->())?{ didSet{
        show = callback != nil
    }}
    
    @objc func colorPanelDidChange(_ sender:AnyObject) {
        if let cp = sender as? NSColorPanel {
            callback?( cp.color )
        }
    }
    
}

