# https://stackoverflow.com/a/53995651

module Graph
  module Queries
    class << self
      def acyclic?(*args, **kwargs, &block)
        Acyclic.call(*args, **kwargs, &block)
      end
    end

    module Acyclic
      class << self
        def call(*args, **kwargs, &block)
          Calculation.new(*args, **kwargs, &block).call
        end
      end

      class GraphRequiredError < StandardError; end

      class Calculation
        def initialize(options = {})
          @graph = options.fetch(:graph) { raise GraphRequiredError }
        end

        def call
          return @acyclic unless @acyclic.nil?

          @acyclic = !graph.nodes.find do |node|
            next if visited.include?(node) || processed.include?(node)

            cyclic?(node)
          end
        end

        private

        attr_reader :graph

        def cyclic?(node)
          visited.add(node)

          cyclic_successor = graph.edges[node].map(&:to).find do |successor|
            visited.include?(successor) || (!processed.include?(successor) && cyclic?(successor))
          end

          visited.delete(node)
          processed.add(node)

          !!cyclic_successor
        end

        def visited
          @visited ||= Set.new
        end

        def processed
          @processed ||= Set.new
        end
      end
    end
  end
end

# def do_test
#   graph = Graph.directed

#   graph.edges.add('u', 'v')
#   graph.edges.add('u', 'x')
#   graph.edges.add('v', 'y')
#   graph.edges.add('w', 'y')
#   graph.edges.add('w', 'z')
#   graph.edges.add('x', 'v')
#   graph.edges.add('y', 'x')
#   graph.edges.add('z', 'z')

#   Graph.queries.acyclic?(graph: graph)
# end
