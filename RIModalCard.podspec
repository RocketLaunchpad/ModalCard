# vi: ft=ruby

Pod::Spec.new do |s|
  s.name = "RIModalCard"
  s.version = "1.0.0"
  s.summary = "ModalCard Library"

  s.description = <<-DESC
  ModalCard Library for iOS
  DESC

  s.homepage = "https://www.rocketinsights.com"

  s.author = "Paul Calnan"

  s.source = { :git => "https://github.com/RocketLaunchpad/RIModalCard.git", :tag => "#{s.version}" }
  s.license = { :type => "MIT" }

  s.platform = :ios, "11.0"
  s.swift_version = "5.0"

  s.source_files = "Sources/ModalCard/**/*.swift"
  s.resources = "Sources/ModalCard/**/*.{storyboard,xcassets,strings,imageset,png}"
end

