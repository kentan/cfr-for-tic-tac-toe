require './node'

class CFRPlayer < Player

  @@histories = {}
  def initialize
    load_data
  end
  def load_data
    count = 0
    File.open("./nodes.txt") do |file|
      while line = file.gets
        count += 1

        history,regret = line.split("*")
        node = Node.new
        node.set_all_regret_sum(eval(regret))
        @@histories[history] = node
      end
    end
  end


  def next_hand(board_player1,board_player2,history)
    count = 2
    rv = []
    node = @@histories[history]
    if node == nil
      puts "fatal error in cfr player"
      exit
    end
    action = node.get_most_regretful_action

    v = action / 3
    h = action % 3

    puts action
    print v,h,1 << v * 3 + h,"\n"
    return 1 << v * 3 + h
  end
end