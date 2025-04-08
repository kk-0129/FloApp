// 𝗙𝗟𝗢 : 𝗗𝗶𝘀𝘁𝗿𝗶𝗯𝘂𝘁𝗲𝗱 𝗛𝗶𝗲𝗿𝗮𝗿𝗰𝗵𝗶𝗰𝗮𝗹 𝗗𝗮𝘁𝗮𝗳𝗹𝗼𝘄 © 𝖪𝖾𝗏𝖾𝗇 𝖪𝖾𝖺𝗋𝗇𝖾𝗒 𝟮𝟬𝟮𝟯
import FloGraph
import FloBox
import Foundation

let APP_PORT = IPv4.Port(9993)
var SHARED_FLO_HUB : Hub = ____default_shared_hub____

private var __default_shared_hub__:Hub?
private var ____default_shared_hub____:Hub{
    if __default_shared_hub__ == nil{
        if let url = Bundle.main.url(forResource:"structs",withExtension:"xml"){
            Struct.load(xml:url)
        }
        if let a = IPv4.local(port:APP_PORT){
            do{
                let n = Device.Name("MyHub")
                let eps = [
                    try UDP.EP(ipa:a)
                ]
                let url = Bundle.main.url(forResource:"devices",withExtension:"xml")
                let hub = url == nil ? Hub(n,eps) : Hub(n,eps,url!)
                __default_shared_hub__ = hub
            }catch let e{ __log__.err("App: \(e.localizedDescription)") }
        }else{ __log__.err("ERROR: failed to create an address for shared hub") }
    }
    return __default_shared_hub__!
}
