# convenience class for figuring out which infinity puzzles to show the user

class UserInfinityPuzzles

  def initialize(user)
    @user = user
  end

  # the next set of puzzles to show the user + config for the front-end
  #
  def next_infinity_puzzle_set(difficulty = nil, puzzle_id = nil)
    target_difficulty = difficulty || current_difficulty
    puzzles = infinity_puzzles_after(target_difficulty, puzzle_id)
    if puzzles.length == 0 and puzzle_id.nil?
      puzzles = [infinity_level(target_difficulty).last_puzzle]
    end
    {
      puzzles: puzzles,
      difficulty: target_difficulty,
      num_solved: @user.present? ? @user.num_infinity_puzzles_solved : nil
    }
  end

  def next_infinity_puzzle
    if @user.present?
      infinity_puzzles_after(
        latest_difficulty,
        last_solved_infinity_puzzle_id(latest_difficulty)
      ).first
    else
      InfinityLevel.find_by(difficulty: latest_difficulty).last_puzzle
    end
  end

  private

  def infinity_level(difficulty)
    InfinityLevel.find_by(difficulty: difficulty)
  end

  def latest_difficulty
    @user.present? ? @user.solved_infinity_puzzles.last&.difficulty : 'easy'
  end

  def current_difficulty
    @user.present? ? latest_difficulty : 'easy'
  end

  def last_solved_infinity_puzzle_id(difficulty)
    if @user.present?
      @user.solved_infinity_puzzles
        .with_difficulty(difficulty).last&.infinity_puzzle_id
    end
  end

  def infinity_puzzles_after(difficulty, puzzle_id)
    if @user.present?
      target_puzzle_id = puzzle_id || last_solved_infinity_puzzle_id(difficulty)
    else
      target_puzzle_id = puzzle_id
    end
    infinity_level(difficulty).puzzles_after_id(target_puzzle_id)
  end
end
