module Graph
  module Queries
    class << self
      def minimum_path(*args, **kwargs, &block)
        MinimumPath.call(*args, **kwargs, &block)
      end
    end

    module MinimumPath
      class << self
        def call(*args, **kwargs, &block)
          Calculation.new(*args, **kwargs, &block).call
        end
      end

      class GraphRequiredError < StandardError; end
      class StartNodeRequiredError < StandardError; end
      class StopNodeRequiredError < StandardError; end

      class Calculation
        def initialize(options = {})
          @graph = options.fetch(:graph) { raise GraphRequiredError }
          @start = options.fetch(:start) { raise StartNodeRequiredError }
          @stop = options.fetch(:stop) { raise StopNodeRequiredError }
        end

        def call
          search

          find
        end

        private

        attr_reader :graph, :start, :stop

        def search
          bfs = Graph.search.bfs(start: start)

          bfs.search do |current_node|
            return if current_node == stop

            neighboring_nodes = graph.edges[current_node].map(&:to)
            unseen_neighboring_nodes = neighboring_nodes.reject { |n| bfs.queue.seen?(n) }

            bfs.queue.enqueue(*unseen_neighboring_nodes)
            unseen_neighboring_nodes.each { |n| paths[n] = current_node }
          end
        end

        def find
          node = stop
          path = [node]

          while paths.key?(node)
            node = paths[node]
            path.unshift(node)
          end

          path
        end

        def paths
          @paths ||= {}
        end
      end
    end
  end
end
