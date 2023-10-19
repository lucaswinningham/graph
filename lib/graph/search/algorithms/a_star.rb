module Graph
  module Search
    module Algorithms
      module AStar
        class StartNodeRequiredError < StandardError; end

        class << self
          def queue(options = {})
            sort_by = options.fetch(:sort_by, nil)
            dequeue_strategy = options.fetch(:dequeue_strategy) do
              if sort_by
                proc do |queue|
                  queue.sort_by!(&sort_by)

                  Queue::Strategy.fifo.call(queue)
                end
              else
                Queue::Strategy.fifo
              end
            end

            Search.queue(dequeue_strategy: dequeue_strategy)
          end

          def call(options = {}, &process_node)
            search_queue = options.fetch(:queue) do
              start = options.fetch(:start) { raise StartNodeRequiredError }

              queue(options.slice(:dequeue_strategy, :sort_by)).tap { |q| q.enqueue(start) }
            end

            Graph.search.call(options.slice(:stop).merge(queue: search_queue), &process_node)
          end
        end
      end
    end
  end
end
