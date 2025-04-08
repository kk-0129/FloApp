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
