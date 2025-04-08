// 𝗙𝗟𝗢 : 𝗗𝗶𝘀𝘁𝗿𝗶𝗯𝘂𝘁𝗲𝗱 𝗛𝗶𝗲𝗿𝗮𝗿𝗰𝗵𝗶𝗰𝗮𝗹 𝗗𝗮𝘁𝗮𝗳𝗹𝗼𝘄 © 𝖪𝖾𝗏𝖾𝗇 𝖪𝖾𝖺𝗋𝗇𝖾𝗒 𝟮𝟬𝟮𝟯
import SpriteKit
import Flo2D
import FloBox
import FloGraph

// MARK: Document

public class FloDocumentView : SKView{}

open class FloDocument: NSDocument, Undoer {
    
    @IBOutlet weak var view2d: FloDocumentView!{ didSet{
        view2d.presentScene(scene2d)
    }}
    var scene2d:Scene2D!
    
    public override init() {
        scene2d = CocoaScene2D(hub:SHARED_FLO_HUB)
        super.init()
        scene2d.undoer = self
    }
    //deinit{ __log__.debug("document deinited") } <-- to make sure it's gone
    
    public override func close(){
        __log__.debug("document closed ..")
        view2d.presentScene(nil)
        scene2d = nil
        super.close()
    }

    public override class var autosavesInPlace: Bool{
        return true
    }

    public override var windowNibName: NSNib.Name? {
        // Returns the nib file name of the document
        // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this property and override -makeWindowControllers instead.
        return NSNib.Name("Document")
    }

    public override func data(ofType t:String)throws->Data{
        if t == "it.eng.flo"{
            return scene2d.serialise()
        }
        throw NSError(domain:NSOSStatusErrorDomain,code:unimpErr,userInfo:nil)
    }
    
    public override func read(from d:Data,ofType t:String)throws{
        if t == "it.eng.flo"{
            try scene2d.deserialise(from:d)
        }else{
            throw NSError(domain:NSOSStatusErrorDomain,code:unimpErr,userInfo:nil)
        }
    }
    
    // MARK: UNDOER
    
    class _U:NSObject{ let cb:()->(); init(_ cb:@escaping ()->()){self.cb=cb}}
    @objc func UNDO(_ u:_U){ u.cb() }
    public func add(undo n:String,_ cb:@escaping ()->()){
        if let um = undoManager{
            um.setActionName(n)
            um.registerUndo(withTarget:self,selector:#selector(self.UNDO(_:)),object:_U(cb))
        }
    }
    
    // MARK: USER INTERACTION
    
    //@IBAction func toggleLog(_ s:Any?){ AppDelegate.shared?.toggleLog(s) }
    @IBAction func copy(_ s:Any?){ scene2d.perform(.CAP(.COPY)) }
    @IBAction func cut(_ s:Any?){ scene2d.perform(.CAP(.CUT)) }
    @IBAction func delete(_ s:Any?){ scene2d.perform(.CAP(.DELETE)) }
    @IBAction func paste(_ s:Any?){ scene2d.perform(.CAP(.PASTE)) }
    @IBAction func selectAll(_ s:Any?){ scene2d.perform(.CAP(.SELECT_ALL)) }
    public override func validateMenuItem(_ menuItem: NSMenuItem)->Bool{
        switch menuItem.tag{
        case 1000: return true // Log Panel
        case 1050: return scene2d.canPerform(.CAP(.COPY))
        case 1051: return scene2d.canPerform(.CAP(.CUT))
        case 1052: return scene2d.canPerform(.CAP(.PASTE))
        case 1053: return scene2d.canPerform(.CAP(.DELETE))
        case 1054: return scene2d.canPerform(.CAP(.SELECT_ALL))
        default: break
        }
        return super.validateMenuItem(menuItem)
    }

}

