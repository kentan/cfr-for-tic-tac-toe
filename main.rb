require './board'
require './human_player'
require './trainer'
require './cfr_player'

class Main
  def play
    board_player1 = 0
    board_player2 = 0

    Board.show_board(board_player1,board_player2)

    human1 = HumanPlayer.new
    cfr = CFRPlayer.new

    players= [human1,cfr]
    human1.board = board_player1
    cfr.board = board_player2

    history = ""
    is_there_winner =false
    for i in 0..5
        for j in 0..1
          valid = false
          while(!valid)
            puts "[" + players[j].class.to_s + "] input >"
            next_hand = players[j].next_hand(players[0].board,players[1].board,history)
            valid = Board.do_put?(next_hand,players[0].board,players[1].board)
          end
          players[j].board = players[j].board | next_hand
          Board.show_board(players[0].board,players[1].board)
          if(Board.is_there_winner?(players[0].board,players[1].board))
            puts "finish"
            exit
          end
          num = Board.get_pos(next_hand)
          history += (":" + num.to_s)
        end

        # next_hand = cfr.next_hand(board_player1,board_player2,history)
        # board_player2 |= next_hand
        # Board.show_board(board_player1,board_player2)
        # if(Board.is_there_winner?(board_player1,board_player2))
        #   break
        # end
        # num = Board.get_pos(next_hand)
        # history += (":" + num.to_s)

    end

#    Board.show_board(board_player1,board_player2)
  end

  def train()
    trainer = Trainer.new
    trainer.train
  end
end


# main = Main.new()
# main.train()
#
# puts "trained"

main = Main.new()
main.play()

# cfr = CFRPlayer.new
# cfr.load_data()