Pod::Spec.new do |s|

  s.name         = "CHWebView"
  s.version      = "1.5"
  s.summary      = "WebView component,progress ,javascript "
  s.description  = "Edit demo project and support local register nativehelper j "
  s.homepage     = "https://github.com/chausson/CHWebView.git"
  s.license      = "MIT"
  s.author       = { "Chausson" => "232564026@qq.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/chausson/CHWebView.git", :tag => "1.4"}
#  s.source_files  = "CHWebView/CHWebViewController.{h.m}"
  s.frameworks = 'WebKit', 'JavaScriptCore'
  s.default_subspecs = "Core","Progress","JavaScript"
  s.subspec 'Core' do |c|
   c.source_files = "CHWebView/Core"
   c.dependency "CHWebView/Progress"
  end
  s.subspec 'Progress' do |p|
   p.source_files = "CHWebView/Progress"
  end
  s.subspec 'JavaScript' do |j|
   j.resources = "CHWebView/JavaScript/nativehelper.js"
  end
end
