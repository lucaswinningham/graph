module Examples
  module NetworkDelayTime
    class Input
      attr_reader :valid, :times, :n, :start

      def initialize(times, n, k)
        @times = times
        @n = n
        @start = k
      end

      def graph
        @graph ||= Graph.directed.tap do |tapped_graph|
          n.times.map { |i| i + 1 }.each { |node| tapped_graph.nodes.add(node) }

          tapped_graph.edges.parse(times)
        end
      end
    end
  end
end
