require_relative 'queue'

module Graph
  describe Search do
    subject { described_class }

    describe '::queue' do
      it 'passes args to Graph::Search::Queue::new' do
        expect(Graph::Search::Queue).to receive(:new).with(queue: :queue)

        subject.queue(queue: :queue)
      end
    end
  end
end

module Graph
  module Search
    describe Queue do
      subject { described_class }

      describe '#dequeue' do
        describe 'when not given a `dequeue_strategy`' do
          let(:nodes) { [1, 2, 3].map(&Graph.search.method(:node)) }
          let(:queue) { subject.new.tap { |q| q.enqueue(*nodes) } }

          it 'defaults to a FIFO dequeue strategy' do
            nodes.each do |node|
              expect(queue.dequeue).to be(node)
            end
          end
        end

        describe 'when given a `dequeue_strategy`' do
          let(:dequeue_strategy) do
            proc do |q|
              q.sort_by! { |node| node.id }

              q.pop
            end
          end

          let(:nodes) { ['c', 'b', 'a'].map(&Graph.search.method(:node)) }

          let(:queue) do
            subject.new(dequeue_strategy: dequeue_strategy).tap { |q| q.enqueue(*nodes) }
          end

          it 'uses the given dequeue strategy' do
            nodes.each do |node|
              expect(queue.dequeue).to be(node)
            end
          end
        end
      end

      describe '#empty?' do
        describe 'when no nodes are enqueued' do
          let(:queue) { subject.new }

          it 'returns `true`' do
            expect(queue.empty?).to be(true)
          end
        end

        describe 'when nodes are enqueued' do
          let(:node) { Graph.search.node(:node) }
          let(:queue) { subject.new.tap { |q| q.enqueue(node) } }

          it 'returns `false`' do
            expect(queue.empty?).to be(false)
          end
        end
      end

      describe '#seen?' do
        describe 'when the node has been enqueued' do
          let(:node) { Graph.search.node(:node) }
          let(:queue) { subject.new.tap { |q| q.enqueue(node) } }

          it 'returns `true`' do
            expect(queue.seen?(node)).to be(true)
          end
        end

        describe 'when the node has not been enqueued' do
          let(:node) { Graph.search.node(:node) }
          let(:queue) { subject.new }

          it 'returns `false`' do
            expect(queue.seen?(node)).to be(false)
          end
        end
      end

      describe '#processed?' do
        describe 'when the node has been dequeued' do
          let(:node) { Graph.search.node(:node) }
          let(:queue) { subject.new.tap { |q| q.enqueue(node) }.tap { |q| q.dequeue } }

          it 'returns `true`' do
            expect(queue.processed?(node)).to be(true)
          end
        end

        describe 'when the node has not been dequeued' do
          let(:node) { Graph.search.node(:node) }
          let(:queue) { subject.new.tap { |q| q.enqueue(node) } }

          it 'returns `false`' do
            expect(queue.processed?(node)).to be(false)
          end
        end
      end

      # def initialize(options = {}, &dequeue_strategy)
      #   @dequeue_strategy = dequeue_strategy || options.fetch(:dequeue_strategy) do
      #     DequeueStrategy.fifo
      #   end
      # end

      # def enqueue(*nodes)
      #   queue.concat(nodes)
      #   seen.merge!(nodes.each_with_object({}) { |n, acc| acc[n.id] = n })
      # end

      # def dequeue
      #   dequeue_strategy.call(queue).tap do |node|
      #     processed.merge!(node.id => node)
      #   end
      # end

      # private

      # attr_reader :dequeue_strategy

      # def queue
      #   @queue ||= []
      # end

      # def seen
      #   @seen ||= {}
      # end

      # def processed
      #   @processed ||= {}
      # end
    end
  end
end
