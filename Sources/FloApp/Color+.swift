// 𝗙𝗟𝗢 : 𝗗𝗶𝘀𝘁𝗿𝗶𝗯𝘂𝘁𝗲𝗱 𝗛𝗶𝗲𝗿𝗮𝗿𝗰𝗵𝗶𝗰𝗮𝗹 𝗗𝗮𝘁𝗮𝗳𝗹𝗼𝘄 © 𝖪𝖾𝗏𝖾𝗇 𝖪𝖾𝖺𝗋𝗇𝖾𝗒 𝟮𝟬𝟮𝟯
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

