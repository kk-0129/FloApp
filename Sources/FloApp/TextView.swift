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
