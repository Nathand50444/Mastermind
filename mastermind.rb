class Mastermind

    def initialize                              # When a new instance of Mastermind is created, this calls the multiple methods and creation of instance variables.
        @turn = 0                               # The turn is set to 0.
        @board = Array.new(96) { " " }          # A new game board is set, consisting of 96 spaces. 12 turns of 8 spaces, and the board is shown.
        show_board                              
        @code_to_break = codemaker_code         # To start the game, the codemaker creates the code that the codebreaker needs to figure out.
        turn                                    # 'turn' is called to start the game.
    end

    def show_board
        puts "---------------------------------"
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} | #{@board[3]} | | | #{@board[4]} | #{@board[5]} | #{@board[6]} | #{@board[7]} |"
        puts "---------------------------------"
        puts " #{@board[8]} | #{@board[9]} | #{@board[10]} | #{@board[11]} | | | #{@board[12]} | #{@board[13]} | #{@board[14]} | #{@board[15]} |" 
        puts "---------------------------------"
        puts " #{@board[16]} | #{@board[17]} | #{@board[18]} | #{@board[19]} | | | #{@board[20]} | #{@board[21]} | #{@board[22]} | #{@board[23]} |" 
        puts "---------------------------------"
        puts " #{@board[24]} | #{@board[25]} | #{@board[26]} | #{@board[27]} | | | #{@board[28]} | #{@board[29]} | #{@board[30]} | #{@board[31]} |" 
        puts "---------------------------------"
        puts " #{@board[32]} | #{@board[33]} | #{@board[34]} | #{@board[35]} | | | #{@board[36]} | #{@board[37]} | #{@board[38]} | #{@board[39]} |"
        puts "---------------------------------"
        puts " #{@board[40]} | #{@board[41]} | #{@board[42]} | #{@board[43]} | | | #{@board[44]} | #{@board[45]} | #{@board[46]} | #{@board[47]} |" 
        puts "---------------------------------"
        puts " #{@board[48]} | #{@board[49]} | #{@board[50]} | #{@board[51]} | | | #{@board[52]} | #{@board[53]} | #{@board[54]} | #{@board[55]} |" 
        puts "---------------------------------"
        puts " #{@board[56]} | #{@board[57]} | #{@board[58]} | #{@board[59]} | | | #{@board[60]} | #{@board[61]} | #{@board[62]} | #{@board[63]} |" 
        puts "---------------------------------"
        puts " #{@board[64]} | #{@board[65]} | #{@board[66]} | #{@board[67]} | | | #{@board[68]} | #{@board[69]} | #{@board[70]} | #{@board[71]} |" 
        puts "---------------------------------"
        puts " #{@board[72]} | #{@board[73]} | #{@board[74]} | #{@board[75]} | | | #{@board[76]} | #{@board[77]} | #{@board[78]} | #{@board[79]} |" 
        puts "---------------------------------"
        puts " #{@board[80]} | #{@board[81]} | #{@board[82]} | #{@board[83]} | | | #{@board[84]} | #{@board[85]} | #{@board[86]} | #{@board[87]} |" 
        puts "---------------------------------"
        puts " #{@board[88]} | #{@board[89]} | #{@board[90]} | #{@board[91]} | | | #{@board[92]} | #{@board[93]} | #{@board[94]} | #{@board[95]} |"  
    end         # The game board is set out, 12 turns of 8 spaces.

    def turn_count
        @turn += 1      # The turn_count method keeps track of the game turn.
    end

    def codemaker_code
        loop do         # Here the codemaker is called to create their 4-digit, numeric code.
            puts "You are the codemaker! Please choose your super secret, 4-digit, numeric code. (e.g 1234)"
            code_to_break = gets.chomp
            if code_to_break.match?(/\A\d{4}\z/)
                return code_to_break.chars.map(&:to_i)
            else
                puts "Invalid input."
            end
        end
    end

    def add_to_gameboard(code_guess)        # To accomodate the large game board, the values are added to the game board based on factors of 8 and the current index of the code_guess.
        offset = @turn * 8                  # i.e. if we are on the fourth turn and the codebreaker makes a guess, the current digit in the iteration will be added to the 4th line based on 4 * 8.
        code_guess.each_with_index do |digit, i|
            @board[i + offset] = digit
        end
    end
    
    def feedback(code_guess, code_to_break)
        code_guess.each_with_index do |digit, i|
            if digit == code_to_break[i]
                @board[4 + @turn * 8 + i] = "Red"
            elsif code_to_break.include?(digit)
                @board[4 + @turn * 8 + i] = "White"
            end
        end             # Based on a Mastermind game board: RED pegs indicate a number that is in the code and in the correct position, and WHITE pegs indictae correct number but wrong position.
    end                 # Comparisons are made between the code_guess and the code_to_break which determines whether a RED, WHITE or NO peg is added to the 4 positions opposite the guess on the game board.
      
    def turn
        loop do
            puts "You are the codebreaker! Guess the 4 digit, numeric code."        # Here the game turn looped through.
            code_guess = gets.chomp                                                 
            if code_guess.match?(/\A\d{4}\z/)                                       # The codebreaker must make a 4 digit, numeric guess.
                code_guess = code_guess.chomp.chars.map(&:to_i)                     
                add_to_gameboard(code_guess)                                        # The code guess is added to the game board.
                feedback(code_guess, @code_to_break)                                # Comparisons are made between the code_guess and the code_to_break.
                show_board                                                          # The game board is shown so the codebreaker can see the feeback.  
                if win_condition?
                    puts "Congratulations! You've cracked the code!"
                    return
                end                                                                 # Here we check the win conditions to see if the game is over.
                turn_count
                if @turn == 12                                                      # If the game reaches 12 turns then the game is over.
                    puts "Game over! You've reached the maximum number of turns."
                    return
                    break
                  end
            else
                puts "Invalid input."
          end
        end
      end

    def win_condition?                      # The win condition method checks that 4 red pegs are in a row which indicates all numbers are correct and in the correct positions.
        @board.each_slice(8) do |row|
            consecutive_red_count = 0
            row.each do |peg|
                if peg == "Red"
                    consecutive_red_count += 1
                    return true if consecutive_red_count == 4
                else
                    consecutive_red_count = 0
                end
            end
        end
        false
    end
end