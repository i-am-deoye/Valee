
Pod::Spec.new do |s|
          #1.
          s.name               = "Valee"
          #2.
          s.version            = "0.0.7"
          #3.  
          s.summary         = "'Valee' framework"
          #4.
          s.homepage        = "https://github.com/i-am-deoye/Valee"
          #5.
          s.license              = "MIT"
          #6.
          s.author               = "Moses Ayankoya"
          #7.
          s.platform            = :ios, "10.0"
          #8.
          s.source              = { :git => "https://github.com/i-am-deoye/Valee.git", :tag => "0.0.7" }
          #9.
          s.source_files     = "Valee", "Valee/**/*.{h,m,swift}"
          s.swift_version = '5'
    end
