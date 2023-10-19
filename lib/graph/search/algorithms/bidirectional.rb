module Graph
  module Search
    module Algorithms
      module Bidirectional
        class StartNodeRequiredError < StandardError; end
        # class IntersectionNodeRequiredError < StandardError; end
        class StopNodeRequiredError < StandardError; end

        class << self
          # def direction
          #   @direction ||= Struct.new(:forward, :backward).new(:forward, :backward)
          # end

          def queue(options = {})
            start_queue = options.fetch(:start_queue) do
              dequeue_strategy = options.fetch(:dequeue_strategy, Search::Queue::Strategy.fifo)

              Search.queue(dequeue_strategy: dequeue_strategy)
            end

            stop_queue = options.fetch(:stop_queue) do
              dequeue_strategy = options.fetch(:dequeue_strategy, Search::Queue::Strategy.fifo)

              Search.queue(dequeue_strategy: dequeue_strategy)
            end

            Queues.new(start_queue: start_queue, stop_queue: stop_queue)
          end

          def call(options = {}, &process_node)
            process_node ||= proc {}

            queues = options.fetch(:queues) do
              start = options.fetch(:start) { raise StartNodeRequiredError }
              stop = options.fetch(:stop) { raise StopNodeRequiredError }

              queue(options.slice(:start_queue, :stop_queue, :dequeue_strategy)).tap do |q|
                q.start_queue.enqueue(start)
                q.stop_queue.enqueue(stop)
              end
            end

            until queues.start_queue.empty? && queues.stop_queue.empty?
              unless queues.start_queue.empty?
                current_node = queues.start_queue.dequeue

                if current_node.id == stop.id || queues.stop_queue.seen?(current_node)
                  return current_node
                end

                process_node.call(current_node, queue.start_queue)
              end

              unless queue.stop_queue.empty?
                current_node = queue.stop_queue.dequeue

                if current_node.id == start.id || queue.start_queue.seen?(current_node)
                  return current_node
                end

                process_node.call(current_node, queue.stop_queue)
              end
            end
          end
        end

        Queues = Struct.new(:start_queue, :stop_queue, keyword_init: true)

        # # TODO: broken
        # class Edges
        #   attr_reader :start_edges, :stop_edges

        #   def initialize(*args, **kwargs, &block)
        #     @start_edges = Search::Edges.new
        #     @stop_edges = Search::Edges.new
        #   end

        #   # TODO: broken
        #   def all_paths(options = {})
        #     start = options.fetch(:start) { raise StartNodeRequiredError }
        #     intersection = options.fetch(:intersection) { raise IntersectionNodeRequiredError }
        #     stop = options.fetch(:stop) { raise StopNodeRequiredError }

        #     start_paths = start_edges.all_paths(start_edges.predecessor(intersection))
        #     stop_paths = stop_edges.all_paths(stop_edges.predecessor(intersection))

        #     start_paths.product(stop_paths).map do |start_min_path, stop_min_path|
        #       [*start_min_path, intersection, *stop_min_path.reverse]
        #     end.tap do |all_paths|
        #       all_paths.each do |path|
        #         first, second, third, *_, antepenultimate, penultimate, ultimate = path

        #         pp first, second, third
        #         puts '...'
        #         pp antepenultimate, penultimate, ultimate
        #       end
        #     end
        #   end

        #   def min_path(options = {}, &sort_by)
        #     all_paths(options).sort_by(&sort_by).at(0)
        #   end
        # end
      end
    end
  end
end
