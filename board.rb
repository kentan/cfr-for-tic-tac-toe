class Board
  @@board_index_max = 8
  def self.board_index_max()
    return @@board_index_max
  end
  @@vertical_len = 3
  @@horizontal_len = 3
  @@board = [[0,0,0],[0,0,0],[0,0,0]]
  @@answer_patterns = [0b000000111,
                       0b000111000,
                       0b111000000,
                       0b001001001,
                       0b010010010,
                       0b100100100,
                       0b100100100,
                       0b100010001,
                       0b001010100]

  def self.show_board(board_player1,board_player2)
    copy1 = board_player1
    copy2 = board_player2
    for i in 0..@@board_index_max
      if ((copy1 >> i & 1 ) == 1)
        h = i % 3
        v = i / 3
        @@board[v][h] = 1
      end

      if ((copy2 >> i & 1 ) == 1)
        h = i % 3
        v = i / 3
        @@board[v][h] = -1
      end
    end

    print "----\n"
    @@board.each do |sub|
      sub.each do |a|
        print a," "

      end
      print "\n"
    end
    print "----\n"
  end

  def self.win?(board_player)
    @@answer_patterns.each do |answer|
      if (answer & board_player) == answer
        return true
      end
    end
    return false
  end

  def self.who_win?(board_player1,board_player2)
    @@answer_patterns.each do |answer|
      if (answer & board_player1) == answer
        return 1
      end
      if (answer & board_player2) == answer
        return -1
      end
    end
    return 0
  end

  def self.is_there_winner?(board_player1,board_player2)
    @@answer_patterns.each do |answer|
      if answer == board_player1
        return true
      end
      if answer == board_player2
        return true
      end
    end
    return false
  end

  def self.get_empty_slots(board_player1,board_player2)
    empty = 0
    copy1 = board_player1
    copy2 = board_player2

    for i in 0..@@board_index_max
      if ((copy1 >> i & 1 ) == 0)
        if ((copy2 >> i & 1 ) == 0)
          empty |= (1 << i)
        end
      end

    end
    return empty
  end

  def self.get_num_of_empty_slot(empty)
    num = 0
    for i in 0..Board.board_index_max
      if (empty >> i & 0b1) == 1
        num += 1
      end
    end
    return num
  end

  def self.get_pos(board)
    num = 0
    for i in 0..Board.board_index_max
      if (board >> i & 0b1) == 0
        num += 1
      else
        break
      end
    end
    return num
  end

  def self.do_put?(next_hand,board_player1,board_player2)
    if next_hand & board_player1 != 0
      return false
    end

    if next_hand & board_player2 != 0
      return false
    end

    return true
  end
end
