
class RandomPlayer < Player

  def next_hand(board_player1,board_player2)
    empty = Board.get_empty_slots(board_player1,board_player2)
    num == 0
    rnd = Random.new()
    while (empty >> num) & 1 == 0
      num = rnd.rand(Board.board_index_max)
    end

    return num

  end
end