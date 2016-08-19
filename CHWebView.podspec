Pod::Spec.new do |s|

  s.name         = "CHWebView"
  s.version      = "1.2"
  s.summary      = "CHWebView is light-weight component garther UIWebView and WKWebView ,progress ,javascript "
  s.description  = "Fix CHWebViewController ProgressView set color error bug "
  s.homepage     = "https://github.com/chausson/CHWebView.git"
  s.license      = "MIT"
  s.author       = { "Chausson" => "232564026@qq.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/chausson/CHWebView.git", :tag => "1.2"}
#  s.source_files  = "CHWebView/CHWebViewController.{h.m}"
  s.frameworks = 'WebKit', 'JavaScriptCore'
  s.default_subspecs = "Core","Progress"
  s.subspec 'Core' do |c|
   c.source_files = "CHWebView/Core"
   c.dependency "CHWebView/Progress"
  end
  s.subspec 'Progress' do |p|
   p.source_files = "CHWebView/Progress"
  end
end
