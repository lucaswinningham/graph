Gem::Specification.new do |spec|
  spec.name = "graph"
  spec.version = "0.0.0"
  spec.summary = "Graph theory API"
  spec.description = "Graph theory API"
  spec.authors = ["Lucas Winningham"]
  spec.homepage = "https://github.com/lucaswinningham/graph"

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
end
