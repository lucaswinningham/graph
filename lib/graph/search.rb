require_relative 'search/algorithms'
require_relative 'search/queues'

module Graph
  class << self
    def search
      Search
    end
  end

  module Search
  end
end
