=begin
https://leetcode.com/problems/network-delay-time/

You are given a network of n nodes, labeled from 1 to n. You are also given times, a list of travel times as directed edges times[i] = (ui, vi, wi), where ui is the source node, vi is the target node, and wi is the time it takes for a signal to travel from source to target.

We will send a signal from a given node k. Return the minimum time it takes for all the n nodes to receive the signal. If it is impossible for all the n nodes to receive the signal, return -1.

Example 1:
Input: times = [[2,1,1],[2,3,1],[3,4,1]], n = 4, k = 2
Output: 2

Example 2:
Input: times = [[1,2,1]], n = 2, k = 1
Output: 1

Example 3:
Input: times = [[1,2,1]], n = 2, k = 2
Output: -1

Constraints:
1 <= k <= n <= 100
1 <= times.length <= 6000
times[i].length == 3
1 <= ui, vi <= n
ui != vi
0 <= wi <= 100
All the pairs (ui, vi) are unique. (i.e., no multiple edges.)
=end

require_relative 'input'

module Examples
  module NetworkDelayTime
    module NetworkDelayTime
      class << self
        def solve(times, n, k)
          input = Input.new(times, n, k)

          graph = input.graph
          start = input.start
          visited = Set.new

          dijkstra = Graph.search.dijkstra(graph: graph, start: start)

          dijkstra.search do |current_node|
            visited.add(current_node)
          end

          return -1 if visited != graph.nodes

          dijkstra.distances.values.max.tap do |network_delay_time|
            return -1 if network_delay_time == Float::INFINITY
          end
        end
      end
    end
  end
end

require 'benchmark'

puts Benchmark.measure {
  # expect 2
  pp Examples::NetworkDelayTime::NetworkDelayTime.solve(
    [[2,1,1],[2,3,1],[3,4,1]],
    4,
    2
  )
}

puts Benchmark.measure {
  # expect 1
  pp Examples::NetworkDelayTime::NetworkDelayTime.solve(
    [[1,2,1]],
    2,
    1
  )
}

puts Benchmark.measure {
  # expect -1
  pp Examples::NetworkDelayTime::NetworkDelayTime.solve(
    [[1,2,1]],
    2,
    2
  )
}
