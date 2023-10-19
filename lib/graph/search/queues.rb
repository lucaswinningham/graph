module Graph
  module Search
    class << self
      def queue(*args, **kwargs, &block)
        Queues::Queue.new(*args, **kwargs, &block)
      end

      def stack(*args, **kwargs, &block)
        Queues::Stack.new(*args, **kwargs, &block)
      end

      def priority_queue(*args, **kwargs, &block)
        Queues::PriorityQueue.new(*args, **kwargs, &block)
      end
    end

    module Queues
      class BasicQueue
        def enqueue(*nodes)
          queue.concat(nodes)
          seen.merge(nodes)
        end

        def dequeue
          dequeue_strategy.call(queue).tap { |node| processed.add(node) }
        end

        def empty?
          queue.empty?
        end

        def queued?(node)
          queue.include?(node)
        end

        def seen?(node)
          seen.include?(node)
        end

        def processed?(node)
          processed.include?(node)
        end

        def peek
          raise NotImplementedError
        end

        private

        def queue
          @queue ||= []
        end

        def seen
          @seen ||= Set.new
        end

        def processed
          @processed ||= Set.new
        end

        def dequeue_strategy
          raise NotImplementedError
        end
      end

      class Queue < BasicQueue
        def dequeue_strategy
          @dequeue_strategy ||= proc { |q| q.shift }
        end

        def peek
          queue.first
        end
      end

      class Stack < BasicQueue
        def dequeue_strategy
          @dequeue_strategy ||= proc { |q| q.pop }
        end

        def peek
          queue.last
        end
      end

      class PriorityQueue < BasicQueue
        def initialize(&heuristic)
          @heuristic = heuristic
        end

        private

        attr_reader :heuristic

        def dequeue_strategy
          @dequeue_strategy ||= proc do |q|
            q.sort_by!(&heuristic)
            q.shift
          end
        end

        def peek
          queue.sort_by(&heuristic).first
        end
      end
    end
  end
end
