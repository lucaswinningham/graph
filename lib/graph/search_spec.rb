require_relative 'search'

describe Graph do
  subject { described_class }

  describe '::search' do
    it 'is `Graph::Search`' do
      expect(subject.search).to be(Graph::Search)
    end
  end
end

module Graph
  describe Search do
    subject { described_class }

    let(:array) { [1, 2, 3] }

    describe '::call' do
      it '`queue` is required' do
        expect { subject.call }.to raise_error(Graph::Search::QueueRequiredError)
      end

      describe 'when `queue` is empty' do
        let(:queue) { subject.queue }

        it 'does not call the given block' do
          expect { |b| subject.call(queue: queue, &b) }.not_to yield_control
        end
      end

      describe 'when `queue` is not empty' do
        let(:nodes) { [1, 2, 3].map(&subject.method(:node)) }
        let(:dequeue_strategy) { Graph::Search::Queue::DequeueStrategy.fifo }
        let(:queue) do
          subject.queue(dequeue_strategy: dequeue_strategy).tap { |q| q.enqueue(*nodes) }
        end

        describe 'when `stop` is not given' do
          it 'calls the given block with current node and queue in order for all nodes' do
            expect { |b| subject.call(queue: queue, &b) }.to(
              yield_successive_args(*nodes.map { |node| [node, queue] })
            )
          end

          it 'returns `nil`' do
            expect(subject.call(queue: queue)).to be_nil
          end
        end

        describe 'when `stop` is given' do
          describe 'when `stop` is found' do
            let(:stop_index) { -1 }
            let(:stop) { nodes[stop_index] }

            it 'calls the given block with current node and queue in order up to `stop`' do
              expect { |b| subject.call(queue: queue, stop: stop, &b) }.to(
                yield_successive_args(*nodes[0..(stop_index - 1)].map { |node| [node, queue] })
              )
            end

            it 'returns `stop`' do
              expect(subject.call(queue: queue, stop: stop)).to eq(stop)
            end
          end

          describe 'when `stop` is not found' do
            let(:stop) { subject.node(4) }

            it 'calls the given block with current node and queue in order for all nodes' do
              expect { |b| subject.call(queue: queue, stop: stop, &b) }.to(
                yield_successive_args(*nodes.map { |node| [node, queue] })
              )
            end

            it 'returns `nil`' do
              expect(subject.call(queue: queue, stop: stop)).to be_nil
            end
          end
        end
      end
    end
  end
end
