
Pod::Spec.new do |s|

  s.name         = "CHWebView"
  s.version      = "0.1" 
  s.summary      = "BaseWebView For Project Complex"
  s.description  = "1.loading webview with progress 
		    2.js invoke oc function
		    3.init URL or File" 
  s.homepage     = "https://github.com/chausson/CHWebView.git"
  s.license      = "MIT"
  s.author       = { "Chausson" => "232564026@qq.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/chausson/CHWebView.git", :tag => "0.1"}
  s.source_files  = "CHWebView/*.{h,m}" 
  s.subspecs 'Core' do |cs|
    sp.source_files = 'CHWebView/Core'
  s.subspecs 'Progress' do |cs|
    sp.source_files = 'CHWebView/Progress'
 
end

