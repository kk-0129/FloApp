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
import SpriteKit
import Flo2D
import FloGraph
import FloBox

extension SKView{
    public override func keyDown(with e: NSEvent){ scene?.keyDown(with:e) }
    public override func scrollWheel(with e:NSEvent){ scene?.scrollWheel(with:e) }
    public override func magnify(with e:NSEvent){ scene?.magnify(with:e) }
}

public class CocoaScene2D:Scene2D{
    
    private func __phase__(_ e:NSEvent,_ momentum:Bool)->Action.Phase?{
        switch e.phase{
        case .began: return .BEGIN
        case .ended: if !momentum{ return .END }else{ fallthrough }
        default: switch e.momentumPhase{
            case .ended: if momentum{ return .END }
            default: break
            }
        }
        return nil
    }
    public override func mouseDown(with e:NSEvent){
        let delta = F2(Float32(e.clickCount),0)
        perform(.POINT(e.locator,delta,e.modifiers,.BEGIN))
    }
    public override func mouseDragged(with e:NSEvent){
        let delta = F2(Float32(e.deltaX),Float32(e.deltaY))
        perform(.POINT(e.locator,delta,e.modifiers,.DELTA))
    }
    public override func mouseUp(with e:NSEvent){
        perform(.POINT(e.locator,F2(0,0),e.modifiers,.END))
    }
    public override func rightMouseDown(with e:NSEvent){
        perform(.POPUP(e.locator))
    }
    private var __scroll_timer__:Timer?
    public override func scrollWheel(with e:NSEvent){
        __scroll_timer__?.invalidate()
        __scroll_timer__ = nil
        if e.phase == .ended{
            __scroll_timer__ = Timer.scheduledTimer(withTimeInterval:0.1,repeats:false){ _ in
                self.perform(.SCROLL(nil))
            }
        }else if e.momentumPhase == .ended{ perform(.SCROLL(nil)) }
        else{ perform(.SCROLL(CGSize(width:e.scrollingDeltaX,height:e.scrollingDeltaY))) }
    }
    public override func magnify(with e: NSEvent){
        perform(.MAGNIFY(e.locator,e.phase == .ended ? nil : Float32(e.magnification)))
    }
    /* KEY DOWN ONLY MAKES SENSE WHEN RUNNING ON THE MAC */
    public override func keyDown(with e:NSEvent){
        if let c = __key_codes__[Int(e.keyCode)]{
            perform(.KEY(c,e.modifiers))
        }else if let key = e.characters?.first{
            perform(.KEY(key,e.modifiers))
        }
    }
}

/*func __keycode__(_ c:Character)->UInt16{
    if let kc = __key_codes__[c]{ return UInt16(kc) }
    return UInt16.max
}*/

import Carbon.HIToolbox.Events
private let __key_codes__:[Int:Character] = [
    kVK_Return : Scene2D.ReturnKey,
    kVK_Delete : Scene2D.BackspaceKey,
    kVK_LeftArrow : Scene2D.LeftArrowKey,
    kVK_RightArrow : Scene2D.RightArrowKey,
    kVK_DownArrow : Scene2D.DownArrowKey,
    kVK_UpArrow : Scene2D.UpArrowKey
]

extension NSEvent{
    var modifiers:Set<Action.Modifier>{
        var res = Set<Action.Modifier>()
        if modifier(.command){ res.insert(.COMMAND) }
        if modifier(.shift){ res.insert(.SHIFT) }
        if modifier(.option){ res.insert(.OPTION) }
        return res
    }
    func modifier(_ f:ModifierFlags)->Bool{
        return modifierFlags.intersection(.deviceIndependentFlagsMask).contains(f)
    }
    var locator:Action.Locator{ return { n in
        if let n = n{ return self.location(in:n) }
        else{ return self.locationInWindow }
    } }
}
