# require_relative 'nodes'

# module Graph
#   describe Search do
#     subject { described_class }
  
#     describe '::nodes' do
#       it 'passes args to Graph::Search::Node::new' do
#         expect(Graph::Search::Node).to receive(:new).with(:nodes)

#         subject.nodes(:nodes)
#       end
#     end
#   end
# end

# module Graph
#   module Search
#     describe Node do
#       subject { described_class }
    
#       describe '#value' do
#         it 'accesses `value` arg from initialization' do
#           expect(subject.new(1).value).to eq(1)
#         end
#       end

#       describe '#value=' do
#         it 'is not defined' do
#           expect { subject.new('hi').value = 'oops' }.to raise_error(NoMethodError)
#         end
#       end
#     end
#   end
# end
