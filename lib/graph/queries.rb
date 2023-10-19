require_relative 'queries/acyclic'
require_relative 'queries/minimum_path'
require_relative 'queries/minimum_paths'
require_relative 'queries/strongly_connected_components'

module Graph
  class << self
    def queries
      Queries
    end
  end

  module Queries
  end
end
