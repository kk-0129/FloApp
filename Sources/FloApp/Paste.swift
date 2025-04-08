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
import Flo2D
import FloBox

private let PBT = "it.eng.pick"

// MARK: ■ Cocoa Pasteboard
import AppKit

public let THE_PASTEBOARD = NSPasteboard.general

private let PBTs:[NSPasteboard.PasteboardType] = [
    NSPasteboard.PasteboardType(PBT)
]

extension NSPasteboard:Flo2D.Pasteboard{
    
    public var canPaste:Bool{
        return THE_PASTEBOARD.availableType(from:[PBTs[0]]) != nil
    }
    
    public var stringContent:String?{
        get{ return string(forType:.string) }
        set(s){ if let s = s{ setString(s,forType:.string) } }
    }
    
    public func write(_ p:Pick){
        _ = clearContents()
        declareTypes([PBTs[0]],owner:nil)
        CIO.cached{ Ω in
            p.™(Ω.clean)
            setData(Data(Ω.bytes),forType:PBTs[0])
        }
    }
    
    public func read()->Pick?{
        if let T = availableType(from:[PBTs[0]]),
            let d = THE_PASTEBOARD.data(forType:T){
            return CIO.cached{ Ω in
                var bs = [UInt8](d)
                Ω.write(ref:&bs)
                do{
                    return try Pick.™(Ω)
                }catch let e{
                    __log__.err(e.localizedDescription)
                    return nil
                }
            }
        }
        return nil
    }
    
}
