require 'pry'

class Mastermind

    def initialize
        @turn = 0
        @board = Array.new(96) { " " }
        show_board
        @code_to_break = codemaker_code
        turn
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
    end

    def turn_count
        @turn += 1
    end

    def codemaker_code
        loop do
            puts "You are the codemaker! Please choose your super secret, 4-digit, numeric code. (e.g 1234)"
            code_to_break = gets.chomp
            if code_to_break.match?(/\A\d{4}\z/)
                return code_to_break.chars.map(&:to_i)
            else
                puts "Invalid input."
            end
        end
    end

    def add_to_gameboard(code_guess)
        offset = @turn * 8
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
        end
    end
      
    def turn
        loop do
            puts "You are the codebreaker! Guess the 4 digit, numeric code."
            code_guess = gets.chomp
            if code_guess.match?(/\A\d{4}\z/)
                code_guess = code_guess.chomp.chars.map(&:to_i)
                add_to_gameboard(code_guess)
                feedback(code_guess, @code_to_break)
                show_board
                if win_condition?
                    puts "Congratulations! You've cracked the code!"
                    return
                end
                turn_count
            else
                puts "Invalid input."
          end
        end
      end

    def win_condition?
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