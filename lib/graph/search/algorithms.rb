require_relative 'algorithms/a_star'
# require_relative 'algorithms/bidirectional'
require_relative 'algorithms/breadth_first_search'
require_relative 'algorithms/depth_first_search'
require_relative 'algorithms/dijkstra'

module Graph
  module Search
    class << self
      # # TODO: fix and test
      # def a_star
      #   Algorithms::AStar
      # end

      # # TODO: fix and test
      # def bidirectional
      #   Algorithms::Bidirectional
      # end

      def bfs(*args, **kwargs, &block)
        Algorithms::BreadthFirstSearch.new(*args, **kwargs, &block)
      end

      def dfs(*args, **kwargs, &block)
        Algorithms::DepthFirstSearch.new(*args, **kwargs, &block)
      end

      def dijkstra(*args, **kwargs, &block)
        Algorithms::Dijkstra.new(*args, **kwargs, &block)
      end
    end

    module Algorithms
    end
  end
end
