module Graph
  module Search
    module Algorithms
      class Dijkstra
        class GraphRequiredError < StandardError; end
        class StartNodeRequiredError < StandardError; end

        attr_reader :graph, :start, :queue

        def initialize(options = {})
          @graph = options.fetch(:graph) { raise GraphRequiredError }
          @start = options.fetch(:start) { raise StartNodeRequiredError }
        end

        def search(&block)
          block ||= proc {}

          until queue.empty?
            current_node = queue.dequeue
            block.call(current_node)

            queued_edges = graph.edges[current_node].select { |edge| queue.queued?(edge.to) }

            queued_edges.each do |queued_edge|
              distance = distances[current_node] + queued_edge.weight

              if distance < distances[queued_edge.to]
                distances[queued_edge.to] = distance
                paths[queued_edge.to] = current_node
              end
            end
          end
        end

        def queue
          @queue ||= Search.priority_queue { |node| distances[node] }.tap do |q|
            q.enqueue(*graph.nodes)
          end
        end

        def distances
          @distances ||= graph.nodes.each_with_object({}) { |node, acc|
            acc[node] = Float::INFINITY
          }.tap do |tapped_distances|
            tapped_distances[start] = 0
          end
        end

        def paths
          @paths ||= {}
        end
      end
    end
  end
end
