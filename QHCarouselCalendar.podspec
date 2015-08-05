Pod::Spec.new do |s|
  s.name         = "QHCarouselCalendar"
  s.version      = "1.1.3"
  s.summary      = "A cool calendar based on iCarousel"
  s.homepage     = "https://github.com/quentinhayot/QHCarouselCalendar"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Quentin Hayot" => "q.hayot@gmail.com" }
  s.source       = { :git => "https://github.com/quentinhayot/QHCarouselCalendar.git", :tag => "1.1.3" }
  s.platform     = :ios, '7.0'
  s.source_files = 'QHCarouselCalendar/QHCarouselCalendar'
  s.requires_arc = true
  s.dependency 'iCarousel', '~> 1.8.1'
  s.dependency 'UIView+Rounded', '~> 0.1.4'
end
