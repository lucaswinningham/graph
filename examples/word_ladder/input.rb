module Examples
  module WordLadder
    class Input
      attr_reader :valid, :start, :stop, :words

      def initialize(start, stop, word_list)
        @valid = word_list.delete(stop)
        @start = start
        @stop = stop
        @words = [start, *word_list, stop]
      end

      def graph
        @graph ||= Graph.undirected.tap do |tapped_graph|
          words.each { |word| tapped_graph.nodes.add(word) }

          words_with_neighbors.each do |word, neighbors|
            neighbors.each do |neighbor|
              tapped_graph.edges.add(word, neighbor)
            end
          end
        end
      end

      private

      def words_with_neighbors
        @words_with_neighbors ||= words.each_with_object(Hash.new { |h, k| h[k] = [] }) do |word, acc|
          word.length.times.each do |index|
            wildcard_chars = word.chars
            wildcard_chars[index] = '*'

            wildcards_with_words[wildcard_chars.join].each do |entry|
              acc[word].push(entry) if entry != word
            end
          end
        end
      end

      def wildcards_with_words
        @wildcards_with_words ||= words.each_with_object(Hash.new { |h, k| h[k] = [] }) do |word, acc|
          word.length.times.each do |index|
            wildcard_chars = word.chars
            wildcard_chars[index] = '*'

            acc[wildcard_chars.join].push(word)
          end
        end
      end
    end
  end
end
