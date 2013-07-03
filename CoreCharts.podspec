Pod::Spec.new do |s|
  s.name         = "CoreCharts"
  s.version      = "0.0.1"
  s.summary      = "The missing iOS charting library."
  s.description  = <<-DESC
                    The missing iOS charting library.
                   DESC
  s.homepage     = "https://github.com/daegren/CoreCharts"
  s.license      = 'MIT', :
  s.author       = { "David Mills" => "dave@1morepx.com" }
  s.source       = { :git => "https://github.com/daegren/CoreCharts.git", :tag => "0.0.1" }
  s.platform     = :ios, '6.0'
  s.source_files = 'Classes', 'CoreCharts/**/*.{h,m}'
  s.requires_arc = true
end
