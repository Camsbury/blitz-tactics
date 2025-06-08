class PuzzleSet < ActiveRecord::Base
  belongs_to :user
  has_many :lichess_v2_puzzles_puzzle_sets
  has_many :lichess_v2_puzzles, through: :lichess_v2_puzzles_puzzle_sets

  PUZZLE_LIMIT = 1_000_000  # arbitrary limit on # of puzzles per puzzle set

  def textarea_puzzle_ids
    lichess_v2_puzzles.pluck(:puzzle_id).join("\n")
  end

  def num_puzzles
    @num_puzzles ||= lichess_v2_puzzles.count
  end

  def random_level
    return lichess_v2_puzzles.map(&:bt_puzzle_data).shuffle
  end
end
