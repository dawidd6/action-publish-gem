Gem::Specification.new do |spec|
  spec.name          = "action"
  spec.version       = "0.0.0"
  spec.authors       = ["Dawid Dziurla"]
  spec.email         = ["dawidd0811@gmail.com"]

  spec.summary       = "Test gem"
  spec.homepage      = "https://github.com/dawidd6/action-publish-gem"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata = { "github_repo" => spec.homepage }

  spec.files = `git ls-files`.split("\n")
end
