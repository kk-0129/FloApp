// 𝗙𝗟𝗢 : 𝗗𝗶𝘀𝘁𝗿𝗶𝗯𝘂𝘁𝗲𝗱 𝗛𝗶𝗲𝗿𝗮𝗿𝗰𝗵𝗶𝗰𝗮𝗹 𝗗𝗮𝘁𝗮𝗳𝗹𝗼𝘄 © 𝖪𝖾𝗏𝖾𝗇 𝖪𝖾𝖺𝗋𝗇𝖾𝗒 𝟮𝟬𝟮𝟯
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
