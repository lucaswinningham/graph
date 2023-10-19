module Graph
  module Search
    module Algorithms
      class DepthFirstSearch
        class StartNodeRequiredError < StandardError; end

        attr_reader :queue

        def initialize(options = {})
          @queue = options.fetch(:queue) do
            start = options.fetch(:start) { raise StartNodeRequiredError }

            Search.stack.tap { |q| q.enqueue(start) }
          end
        end

        def search(&process_node)
          process_node ||= proc {}
  
          until queue.empty?
            current_node = queue.dequeue
  
            process_node.call(current_node)
          end
        end
      end
    end
  end
end
