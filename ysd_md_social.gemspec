Gem::Specification.new do |s|
  s.name    = "ysd_md_social"
  s.version = "0.2.0"
  s.authors = ["Yurak Sisa Dream"]
  s.date    = "2011-08-23"
  s.email   = ["yurak.sisa.dream@gmail.com"]
  s.files   = Dir['lib/**/*.rb']
  s.summary = "Yurak Sisa Social extension"
  s.homepage = "http://github.com/yuraksisa/ysd_md_social"  
  
  s.add_runtime_dependency "data_mapper", "1.2.0"

  s.add_runtime_dependency "ysd_md_cms"        # CMS
  s.add_runtime_dependency "ysd_md_profile"    # Block permissions
  s.add_runtime_dependency "ysd_core_plugins"  # Plugins (content type aspects)
  
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "dm-sqlite-adapter" # Model testing using sqlite

end
