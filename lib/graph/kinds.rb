module Graph
  class << self
    def new(options = {})
      options.delete(:directed) ? directed : undirected
    end

    def directed
      Kinds::Directed.new
    end

    def undirected
      Kinds::Undirected.new
    end
  end

  module Kinds
    class BasicGraph
      def nodes
        @nodes ||= Set.new
      end
    end

    class Directed < BasicGraph
      def edges
        @edges ||= Graph.edges do |from, to, options = {}|
          nodes.add(from)
          nodes.add(to)
        end
      end
    end

    class Undirected < BasicGraph
      def edges
        @edges ||= Graph.edges do |from, to, options = {}|
          nodes.add(from)
          nodes.add(to)

          edges.add(to, from, options)
        end
      end
    end
  end
end
