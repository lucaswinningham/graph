module Graph
  class << self
    def edges(*args, **kwargs, &block)
      Edges.new(*args, **kwargs, &block)
    end
  end

  class Edges
    def initialize(&on_add)
      @on_add = on_add || proc {}
    end

    def parse(input)
      input.each { |from, to, weight = 1| add(from, to, weight: weight) }
    end

    def add(from, to, options = {})
      tap do
        unless edge?(from, to)
          weight = options.fetch(:weight, 1)
          edge = Edge.new(from, to, weight: weight)

          edges[edge.from].push(edge)

          on_add.call(from, to, weight: weight)
        end
      end
    end

    def edge?(from, to)
      edges[from].map(&:to).include?(to)
    end

    def [](from)
      edges[from]
    end

    def each(&block)
      edges.reduce([]) { |acc, (_, node_edges)| [*acc, *node_edges] }.each(&block)
    end

    private

    attr_reader :on_add

    def edges
      @edges ||= Hash.new { |h, from| h[from] = [] }
    end
  end

  class Edge
    attr_reader :from, :to, :weight

    def initialize(from, to, options = {})
      @from = from
      @to = to
      @weight = options.fetch(:weight, 1)
    end
  end
end
