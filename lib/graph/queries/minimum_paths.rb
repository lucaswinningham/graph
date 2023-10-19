module Graph
  module Queries
    class << self
      def minimum_paths(*args, **kwargs, &block)
        MinimumPaths.call(*args, **kwargs, &block)
      end
    end

    module MinimumPaths
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

          find(start, stop)
        end

        private

        attr_reader :graph, :start, :stop

        def search
          bfs = Graph.search.bfs(start: start)
          depths = Hash.new { |h, k| h[k] = Float::INFINITY }
          depths[start] = 0

          bfs.search do |current_node|
            return if current_node == stop

            neighboring_nodes = graph.edges[current_node].map(&:to)
            seen_neighboring_nodes, unseen_neighboring_nodes = neighboring_nodes.partition do |n|
              bfs.queue.seen?(n)
            end

            bfs.queue.enqueue(*unseen_neighboring_nodes)

            unseen_neighboring_nodes.each do |unseen_neighboring_node|
              depths[unseen_neighboring_node] = depths[current_node] + 1

              paths[unseen_neighboring_node].push(current_node)
            end

            seen_neighboring_nodes.each do |seen_neighboring_node|
              neighbor_predecessor_depth = depths.slice(*paths[seen_neighboring_node]).values.min

              if depths[current_node] == neighbor_predecessor_depth
                paths[seen_neighboring_node].push(current_node)
              end
            end
          end
        end

        def find(from, to)
          return [[to]] if from == to
  
          predecessors_paths = paths[to].reduce([]) do |acc, predecessor|
            [*acc, *find(from, predecessor)]
          end
  
          predecessors_paths.map { |path| [*path, to] }
        end

        def paths
          @paths ||= Hash.new { |h, k| h[k] = [] }
        end
      end
    end
  end
end
