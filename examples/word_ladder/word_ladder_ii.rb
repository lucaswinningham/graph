=begin
https://leetcode.com/problems/word-ladder-ii/

A transformation sequence from word beginWord to word endWord using a dictionary wordList is a sequence of words beginWord -> s1 -> s2 -> ... -> sk such that:
Every adjacent pair of words differs by a single letter.
Every si for 1 <= i <= k is in wordList. Note that beginWord does not need to be in wordList.
sk == endWord
Given two words, beginWord and endWord, and a dictionary wordList, return all the shortest transformation sequences from beginWord to endWord, or an empty list if no such sequence exists. Each sequence should be returned as a list of the words [beginWord, s1, s2, ..., sk].

Example 1:
Input: beginWord = "hit", endWord = "cog", wordList = ["hot","dot","dog","lot","log","cog"]
Output: [["hit","hot","dot","dog","cog"],["hit","hot","lot","log","cog"]]
Explanation: There are 2 shortest transformation sequences:
"hit" -> "hot" -> "dot" -> "dog" -> "cog"
"hit" -> "hot" -> "lot" -> "log" -> "cog"

Example 2:
Input: beginWord = "hit", endWord = "cog", wordList = ["hot","dot","dog","lot","log"]
Output: []
Explanation: The endWord "cog" is not in wordList, therefore there is no valid transformation sequence.

Constraints:
1 <= beginWord.length <= 5
endWord.length == beginWord.length
1 <= wordList.length <= 500
wordList[i].length == beginWord.length
beginWord, endWord, and wordList[i] consist of lowercase English letters.
beginWord != endWord
All the words in wordList are unique.
The sum of all shortest transformation sequences does not exceed 105.
=end

require_relative 'input'

module Examples
  module WordLadder
    module WordLadderII
      class << self
        def solve(begin_word, end_word, word_list)
          input = Input.new(begin_word, end_word, word_list).tap { |i| return [] unless i.valid }

          graph = input.graph
          start = input.start
          stop = input.stop

          Graph.queries.minimum_paths(graph: graph, start: start, stop: stop)
        end
      end
    end
  end
end

# def find_ladders(begin_word, end_word, word_list)
#   Examples::WordLadder::WordLadderII.solve(begin_word, end_word, word_list)
# end

require 'benchmark'

puts Benchmark.measure {
  # expect [['hit', 'hot', 'dot', 'dog', 'cog'], ['hit', 'hot', 'lot', 'log', 'cog']]
  pp Examples::WordLadder::WordLadderII.solve(
    'hit',
    'cog',
    ['hot','dot','dog','lot','log','cog']
  )
}

puts Benchmark.measure {
  # expect [
  #   ['hit', 'lit', 'lot', 'log', 'cog'],
  #   ['hit', 'hot', 'lot', 'log', 'cog'],
  #   ['hit', 'hot', 'dot', 'dog', 'cog']
  # ]
  pp Examples::WordLadder::WordLadderII.solve(
    'hit',
    'cog',
    ['hot','dot','dog','lit','lot','log','cog']
  )
}

puts Benchmark.measure {
  # expect [
  #   ['qa', 'ca', 'cm', 'sm', 'sq'],
  #   ['qa', 'fa', 'fm', 'sm', 'sq'],
  #   ['qa', 'ta', 'tm', 'sm', 'sq'],
  #   ['qa', 'pa', 'pm', 'sm', 'sq'],
  #   ['qa', 'ca', 'ci', 'si', 'sq'],
  #   ['qa', 'ba', 'bi', 'si', 'sq'],
  #   ['qa', 'ma', 'mi', 'si', 'sq'],
  #   ['qa', 'ha', 'hi', 'si', 'sq'],
  #   ['qa', 'na', 'ni', 'si', 'sq'],
  #   ['qa', 'la', 'li', 'si', 'sq'],
  #   ['qa', 'ta', 'ti', 'si', 'sq'],
  #   ['qa', 'pa', 'pi', 'si', 'sq'],
  #   ['qa', 'ca', 'cr', 'sr', 'sq'],
  #   ['qa', 'ba', 'br', 'sr', 'sq'],
  #   ['qa', 'fa', 'fr', 'sr', 'sq'],
  #   ['qa', 'ma', 'mr', 'sr', 'sq'],
  #   ['qa', 'la', 'lr', 'sr', 'sq'],
  #   ['qa', 'ca', 'co', 'so', 'sq'],
  #   ['qa', 'ya', 'yo', 'so', 'sq'],
  #   ['qa', 'ma', 'mo', 'so', 'sq'],
  #   ['qa', 'ga', 'go', 'so', 'sq'],
  #   ['qa', 'ha', 'ho', 'so', 'sq'],
  #   ['qa', 'na', 'no', 'so', 'sq'],
  #   ['qa', 'la', 'lo', 'so', 'sq'],
  #   ['qa', 'ta', 'to', 'so', 'sq'],
  #   ['qa', 'pa', 'po', 'so', 'sq'],
  #   ['qa', 'ba', 'be', 'se', 'sq'],
  #   ['qa', 'ra', 're', 'se', 'sq'],
  #   ['qa', 'fa', 'fe', 'se', 'sq'],
  #   ['qa', 'ya', 'ye', 'se', 'sq'],
  #   ['qa', 'ma', 'me', 'se', 'sq'],
  #   ['qa', 'ga', 'ge', 'se', 'sq'],
  #   ['qa', 'ha', 'he', 'se', 'sq'],
  #   ['qa', 'na', 'ne', 'se', 'sq'],
  #   ['qa', 'la', 'le', 'se', 'sq'],
  #   ['qa', 'ra', 'rn', 'sn', 'sq'],
  #   ['qa', 'ma', 'mn', 'sn', 'sq'],
  #   ['qa', 'la', 'ln', 'sn', 'sq'],
  #   ['qa', 'ra', 'rh', 'sh', 'sq'],
  #   ['qa', 'ta', 'th', 'sh', 'sq'],
  #   ['qa', 'pa', 'ph', 'sh', 'sq'],
  #   ['qa', 'ra', 'rb', 'sb', 'sq'],
  #   ['qa', 'ya', 'yb', 'sb', 'sq'],
  #   ['qa', 'ma', 'mb', 'sb', 'sq'],
  #   ['qa', 'na', 'nb', 'sb', 'sq'],
  #   ['qa', 'ta', 'tb', 'sb', 'sq'],
  #   ['qa', 'pa', 'pb', 'sb', 'sq'],
  #   ['qa', 'ma', 'mt', 'st', 'sq'],
  #   ['qa', 'la', 'lt', 'st', 'sq'],
  #   ['qa', 'pa', 'pt', 'st', 'sq'],
  #   ['qa', 'ta', 'tc', 'sc', 'sq']
  # ]
  pp Examples::WordLadder::WordLadderII.solve(
    'qa',
    'sq',
    ['si','go','se','cm','so','ph','mt','db','mb','sb','kr','ln','tm','le','av','sm','ar','ci','ca','br','ti','ba','to','ra','fa','yo','ow','sn','ya','cr','po','fe','ho','ma','re','or','rn','au','ur','rh','sr','tc','lt','lo','as','fr','nb','yb','if','pb','ge','th','pm','rb','sh','co','ga','li','ha','hz','no','bi','di','hi','qa','pi','os','uh','wm','an','me','mo','na','la','st','er','sc','ne','mn','mi','am','ex','pt','io','be','fm','ta','tb','ni','mr','pa','he','lr','sq','ye']
  )
}
