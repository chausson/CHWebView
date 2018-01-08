window.NativeBridge = function(name,message){
    var iosDevice = !!navigator.userAgent.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/);
    if(iosDevice){
       // Apple
       if(this.hasOwnProperty(name)){
            eval("window."+name+"(message)")
       }else{
            if(message == null){
                message = ''
           }
            eval("webkit.messageHandlers."+name+".postMessage(message)")
       }
    }
}

