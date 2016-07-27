#作用
    通过拦截URL的机制进行Native与H5之间进行相互调用,前端开发人员使用a标签进行Native调用,客户端根据协议进行相应的响应,具体规则遵循约定的协议。


##使用示例-javascript

```javascript
    <a href="app://href\http://www.baidu.com?title=新的标题&id=10001">href</a>
    <a href="app://action?title=跳转腾讯&id=10002">action</a>
    <a href="app://JSDemo">JSDemo</a>
```
##javascript说明
通过以上方式可以调用APP的方法，并且通过?后面的key-Value转换成json传入APP

* app:// 表示需要与Nactive进行交互

* protocol
    + action的前缀代表会触发Native方法 [action:]
    
    + href的前缀表示不仅包含action的方法,也会触发url跳转,需要把url参数如示例中拼接在后面


* 所有参数的拼接等同于http协议在?后面拼接key-value，并用&号分割.

* key:参数名称

* value:具体参数值

##使用示例-APP

```bash
      -(void)action:(id)json{
  
      }
      
      public action(JSONObject json) {
       
      }
```
##APP说明
继承封装好的BaseWebView,在该类中重写父类的方法-action,该方法会返回h5中传入的参数,实现js调用oc的交互.