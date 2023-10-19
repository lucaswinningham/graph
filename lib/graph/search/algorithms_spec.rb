require_relative 'algorithms'

module Graph
  describe Search do
    subject { described_class }

    describe '::a_star' do
      it 'is `Graph::Search::Algorithms::AStar`' do
        expect(subject.a_star).to be(Graph::Search::Algorithms::AStar)
      end
    end

    # describe '::bidirectional' do
    #   it 'is `Graph::Search::Algorithms::Bidirectional`' do
    #     expect(subject.bidirectional).to be(Graph::Search::Algorithms::Bidirectional)
    #   end
    # end

    describe '::bfs' do
      it 'is `Graph::Search::Algorithms::BreadthFirstSearch`' do
        expect(subject.bfs).to be(Graph::Search::Algorithms::BreadthFirstSearch)
      end
    end

    describe '::dfs' do
      it 'is `Graph::Search::Algorithms::DepthFirstSearch`' do
        expect(subject.dfs).to be(Graph::Search::Algorithms::DepthFirstSearch)
      end
    end

    # describe '::dijkstra' do
    #   it 'is `Graph::Search::Algorithms::Dijkstra`' do
    #     expect(subject.dijkstra).to be(Graph::Search::Algorithms::Dijkstra)
    #   end
    # end
  end
end
