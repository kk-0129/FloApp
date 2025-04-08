// 𝗙𝗟𝗢 : 𝗗𝗶𝘀𝘁𝗿𝗶𝗯𝘂𝘁𝗲𝗱 𝗛𝗶𝗲𝗿𝗮𝗿𝗰𝗵𝗶𝗰𝗮𝗹 𝗗𝗮𝘁𝗮𝗳𝗹𝗼𝘄 © 𝖪𝖾𝗏𝖾𝗇 𝖪𝖾𝖺𝗋𝗇𝖾𝗒 𝟮𝟬𝟮𝟯
import Cocoa
import Flo2D
import AppKit

let BG = Color(0.1,0.1,0.1,1)
let FG = BG.contrast

public typealias ATTRS = [NSAttributedString.Key:Any]
public func __attrs(bold:Bool,_ fg:Color,_ bg:Color,_ u:Color?,_ z:CGFloat)->ATTRS{
    return [
        .font: bold ? BOLD_FONT(size:z) : NORMAL_FONT(size:z),
        .foregroundColor: fg,
        .backgroundColor: Color.clear,
        .underlineStyle: u == nil ? 0 : 1,
        .underlineColor: u ?? Color.red
    ]
}
func __setButtonTitle(_ b:NSButton,_ s:String,_ c:Color,_ z:CGFloat=14){
    let a = __attrs(bold:false,c,.clear,nil,z)
    b.attributedTitle = NSAttributedString(string:s,attributes:a)
    
}

// MARK: ■ ColoredView
public class ColoredView: NSView{
    
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var backgroundColor = Color.clear{ didSet{ needsDisplay = true }}
    
    public override var isOpaque: Bool{ return false }
    
    public override func draw(_ dirtyRect:NSRect){
        backgroundColor.setFill()
        dirtyRect.fill()
        super.draw(dirtyRect)
    }
    
}

// MARK: ■ TextView
open class TextView: NSTextView{
    
    var _attrs:[NSAttributedString.Key:Any]!
    
    public override func awakeFromNib(){
        super.awakeFromNib()
        backgroundColor = BG
        textColor = FG
    }
    
}
