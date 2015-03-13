require './player'

class HumanPlayer < Player

  def next_hand(board_player1,board_player2,history)
    count = 2
    rv = []
    ARGF.each do |line|
      num = Integer(line.slice(0,1))
      rv.push(num)
      count -= 1

      if count <= 0
        break
      end
    end

    return 1 << rv[0] * 3 + rv[1]
  end
end
