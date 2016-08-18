window.nativeFunc = function(name,message){
    var iosDevice = !!navigator.userAgent.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/);
    var androidDevice = navigator.userAgent.indexOf('Android') > -1 || navigator.userAgent.indexOf('Adr');
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
    }else if(androidDevice){
        eval("messageHandlers."+name+"(message)")
       //Android
    }
}

