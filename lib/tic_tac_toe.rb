class TicTacToe



    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
    ]
    
    def initialize
        @board = Array.new(9, " ")
    end

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(input)
        input.to_i - 1
    end

    def move(idx, token = "X")
        @board[idx] = token
    end

    def position_taken?(idx)
        @board[idx] != " " ? true : false
    end
        
    def valid_move?(idx)
        idx.class == Integer && idx.between?(0, 8) && !position_taken?(idx) ? true : false
    end

    def turn_count
        9 - @board.count(" ")
    end

    def current_player
        turn_count.even? ? "X" : "O"
    end

    def turn
        puts "Specify position between 1-9"

        input = gets

        idx = input_to_index(input)
        
        valid_move?(idx) ? move(idx, current_player) && display_board : turn     
    end

    def won?
        x_s = @board.map.with_index { |val, idx| idx if val == "X" }.compact
        o_s = @board.map.with_index { |val, idx| idx if val == "O" }.compact

        x_win = WIN_COMBINATIONS.map { |win| (win & x_s) == win }
        o_win = WIN_COMBINATIONS.map { |win| (win & o_s) == win }

        if x_win.include?(true)
            WIN_COMBINATIONS[x_win.index(true)]
        elsif o_win.include?(true)
            WIN_COMBINATIONS[o_win.index(true)]
        else
            false
        end
    end

    def full?
        @board.count(" ") == 0
    end

    def draw?
        !won? && full? ? true : false
    end

    def over?
        won? || full? ? true : false
    end

    def winner
        won? ? current_player == "O" ? "X" : "O" : nil
    end

    def play
        until over? || draw? do
            turn
        end

        if won?
            puts "Congratulations #{winner}!"
        elsif draw?
            puts "Cat's Game!"
        end
    end
end