# Tarjan:
# https://en.wikipedia.org/wiki/Tarjan%27s_strongly_connected_components_algorithm

module Graph
  module Queries
    class << self
      def strongly_connected_components(*args, **kwargs, &block)
        StronglyConnectedComponents.call(*args, **kwargs, &block)
      end
    end

    module StronglyConnectedComponents
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
          graph.nodes.each do |node|
            next if indexes.key?(node)

            strongly_connect(node)
          end

          strongly_connected_components
        end

        private

        attr_reader :graph

        def strongly_connect(node)
          index = indexes.length
          indexes[node] = index
          low_links[node] = index

          stack.enqueue(node)

          graph.edges[node].map(&:to).each do |successor|
            if !indexes.key?(successor)
              strongly_connect(successor)

              low_links[node] = [low_links[node], low_links[successor]].min
            elsif stack.queued?(successor)
              low_links[node] = [low_links[node], indexes[successor]].min
            end
          end

          if low_links[node] == indexes[node]
            component_node = stack.dequeue
            component = [component_node]

            while component_node != node
              component_node = stack.dequeue
              component.push(component_node)
            end

            strongly_connected_components.push(component)
          end
        end

        def stack
          @stack ||= Graph.search.stack
        end

        def indexes
          @indexes ||= {}
        end

        def low_links
          @low_links ||= {}
        end

        def strongly_connected_components
          @strongly_connected_components ||= []
        end
      end
    end
  end
end

def do_test
  graph = Graph.directed

  graph.edges.add(1, 2)
  graph.edges.add(2, 1)
  graph.edges.add(2, 5)
  graph.edges.add(3, 4)
  graph.edges.add(4, 3)
  graph.edges.add(4, 5)
  graph.edges.add(5, 6)
  graph.edges.add(6, 7)
  graph.edges.add(7, 8)
  graph.edges.add(8, 6)
  graph.edges.add(8, 9)
  graph.edges.add(9, 9)

  Graph.queries.strongly_connected_components(graph: graph)
end
