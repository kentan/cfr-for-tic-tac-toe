require './board'
require './node'

class Trainer
  @@is_trainer_for_first = false
  @@id = 1
  @@histories = {}
  @@flag = false
  def train

    board_player1 = 0
    board_player2 = 0

    Board.show_board(board_player1,board_player2)

    cfr(1,1,board_player1,board_player2,"")
    File.open("./nodes.txt","w") do |file|
      @@histories.each do |k,v|
        file.print k,"*",v.get_all_regret_sum,"\n"

     end
    end


  end

  def cfr(my_prob,opp_prob,board_player1,board_player2,history)
    # check winner
    win = Board.win?(board_player2)

    if win # if winner then return result
      first = (history.length / 2 ) % 2 == 1
      return @@is_trainer_for_first ? (first ? 1 : -1) : (first ? -1 : 1)
    end

    empty = Board.get_empty_slots(board_player1,board_player2)
    num = Board.get_num_of_empty_slot(empty)

    if num == 0 # end of the game
      return 0
    end

    points = {}
    utility = 0
    for i in 0..Board.board_index_max
      if (empty >> i & 0b1) == 1
        pos = 1 << i
        copied_board_player1 = board_player1 | pos

        p = cfr(opp_prob,my_prob.to_f/num.to_f,board_player2,copied_board_player1,history+":" + Math.log2(pos).to_i.to_s)
        points[p] = i
        utility += (my_prob/num) * p
      end
    end
    store_regret(history,points,utility,opp_prob)
    return utility
  end

  def store_regret(history,points,utility,opp_prob)
    node = ""
    if @@histories.has_key?(history)
      node = @@histories[history]
    else
      node = Node.new()
      @@histories[history] = node
    end

    points.each do |point,action|

      regret = point - utility
      node.set_regret_sum(action,opp_prob * regret)
    end
  end
end

