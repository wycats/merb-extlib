Gem::Specification.new do |s|
  s.files = ["LICENSE",
 "Rakefile",
 "spec/hash_spec.rb",
 "spec/object_spec.rb",
 "spec/set_spec.rb",
 "spec/spec_helper.rb",
 "spec/string_spec.rb",
 "spec/time_spec.rb",
 "lib/merb-extlib",
 "lib/merb-extlib/class.rb",
 "lib/merb-extlib/hash.rb",
 "lib/merb-extlib/logger.rb",
 "lib/merb-extlib/mash.rb",
 "lib/merb-extlib/object.rb",
 "lib/merb-extlib/object_space.rb",
 "lib/merb-extlib/rubygems.rb",
 "lib/merb-extlib/set.rb",
 "lib/merb-extlib/string.rb",
 "lib/merb-extlib/time.rb",
 "lib/merb-extlib/version.rb",
 "lib/merb-extlib/virtual_file.rb",
 "lib/merb-extlib.rb"]
  s.description = "Ruby core extensions library extracted from Merb."
  s.add_dependency "rake", ">= 0, runtime"
  s.add_dependency "json_pure", ">= 0, runtime"
  s.add_dependency "rspec", ">= 0, runtime"
  s.version = "0.9.4"
  s.date = "Sun Jul 20 00:00:00 +0300 2008"
  s.authors = ["Ezra Zygmuntowicz"]
  s.bindir = "bin"
  s.required_rubygems_version = ">= 0"
  s.has_rdoc = "true"
  s.specification_version = "2"
  s.loaded = "false"
  s.email = "ez@engineyard.com"
  s.required_ruby_version = ">= 1.8.4"
  s.extra_rdoc_files = ["README", "LICENSE"]
  s.rubygems_version = "1.2.0"
  s.homepage = "http://merbivore.com"
  s.requirements = ["install the json gem to get faster json parsing"]
  s.platform = "ruby"
  s.require_paths = ["lib"]
  s.summary = "Ruby core extensions library extracted from Merb."
  s.name = "merb-extlib"
end