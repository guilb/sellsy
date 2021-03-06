# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: sellsy 0.3.1.2 ruby lib

Gem::Specification.new do |s|
  s.name = "sellsy"
  s.version = "0.3.1.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["François Guilbert"]
  s.date = "2019-02-13"
  s.description = "Ruby Gem for Sellsy"
  s.email = "francois.guilbert@neoweb.fr"
  s.extra_rdoc_files = [
    "LICENSE",
    "LICENSE.txt",
    "README.md",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE",
    "LICENSE.txt",
    "README.md",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "lib/sellsy.rb",
    "lib/sellsy/addresses.rb",
    "lib/sellsy/api.rb",
    "lib/sellsy/clients.rb",
    "lib/sellsy/contacts.rb",
    "lib/sellsy/documents.rb",
    "lib/sellsy/invoices.rb",
    "lib/sellsy/opportunities.rb",
    "lib/sellsy/prospects.rb",
    "sellsy.gemspec",
    "test/helper.rb",
    "test/test_sellsy.rb"
  ]
  s.homepage = "http://github.com/faustus7/sellsy"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.3"
  s.summary = "Sellsy Client API"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<multi_json>, ["~> 1.11"])
      s.add_runtime_dependency(%q<rest-client>, ["~> 2.0.2"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 2.0"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
    else
      s.add_dependency(%q<multi_json>, ["~> 1.10.0"])
      s.add_dependency(%q<rest-client>, ["~> 2.0.2"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<bundler>, ["~> 1.0"])
      s.add_dependency(%q<jeweler>, ["~> 2.0"])
      s.add_dependency(%q<simplecov>, [">= 0"])
    end
  else
    s.add_dependency(%q<multi_json>, ["~> 1.10.0"])
    s.add_dependency(%q<rest-client>, ["~> 2.0.2"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<bundler>, ["~> 1.0"])
    s.add_dependency(%q<jeweler>, ["~> 2.0"])
    s.add_dependency(%q<simplecov>, [">= 0"])
  end
end

