// 𝗙𝗟𝗢 : 𝗗𝗶𝘀𝘁𝗿𝗶𝗯𝘂𝘁𝗲𝗱 𝗛𝗶𝗲𝗿𝗮𝗿𝗰𝗵𝗶𝗰𝗮𝗹 𝗗𝗮𝘁𝗮𝗳𝗹𝗼𝘄 © 𝖪𝖾𝗏𝖾𝗇 𝖪𝖾𝖺𝗋𝗇𝖾𝗒 𝟮𝟬𝟮𝟯
import Cocoa
import Flo2D
import FloBox
import AppKit

// MARK: ■ LogView
let TEXT_SIZE = CGFloat(16)
let LOG_INFO_ATTRS = __attrs(bold:false,Color(0.8,0.9,1,1),BG,nil,TEXT_SIZE)
let LOG_WARN_ATTRS = __attrs(bold:false,Color(0.9,0.9,0.9,1),BG,nil,TEXT_SIZE)
let LOG_ERR_ATTRS = __attrs(bold:false,Color(1,0.9,0.9,1),BG,nil,TEXT_SIZE)
let LOG_DEBUG_ATTRS = __attrs(bold:false,Color(0.3,0.9,0.3,1),BG,nil,TEXT_SIZE)

public class LogView: TextView,Logger{
    
    @IBOutlet weak var cpuProgress:NSProgressIndicator!
    @IBOutlet weak var cpuValue:NSTextField!
    
    public override func awakeFromNib(){
        super.awakeFromNib()
        backgroundColor = Color(0,0,0,0)
        isEditable = false
        isSelectable = false
        __log__ = self
    }
    
    public var on:Bool = true
    
    public func info(_ m:String){ if on{ _log(m,LOG_INFO_ATTRS) } }
    public func warn(_ m:String){ _log("warn: "+m,LOG_WARN_ATTRS) }
    public func err(_ m:String){ _log("err: "+m,LOG_ERR_ATTRS) }
    public func debug(_ m: String){ _log("▪︎ "+m,LOG_DEBUG_ATTRS) }
    public func clear(){
        DispatchQueue.main.async { self.string = "" }
    }
    
    fileprivate func _log(_ msg:String,_ a:ATTRS){
        DispatchQueue.main.async{ [weak self] in self?.___log(msg,a) }
    }
    
    fileprivate func ___log(_ msg:String,_ a:ATTRS){
        if let t = textStorage{
            //t.append( NSAttributedString(string:"[\(Date.now)] ",attributes:_attrs) )
            t.append( NSAttributedString(string:msg+"\n",attributes:a) )
            scrollToEndOfDocument(self)
        }
    }
    
    override public func mouseDown(with e:NSEvent){
        if e.clickCount == 3{ clear() }
        super.mouseDown(with: e)
    }
    
}
