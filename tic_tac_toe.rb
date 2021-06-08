
class Cell
  attr_reader :output, :state

  def initialize
    @output = ' '
    @state = 0
  end

  def turn(x_o)
    if x_o == 'x'
      @state = 1
      @output = 'x'
    else
      @state = 2
      @output = 'o'
    end
  end
end

class Game
  WINNING_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ]

  def initialize
    puts 'Enter Player 1:'
    @player1 = gets.chomp
    puts 'Enter Player 2:'
    @player2 = gets.chomp

    puts '------------'
    puts [[' 1 | 2 | 3 '],
          [' 4 | 5 | 6 '],
          [' 7 | 8 | 9 ']]
    puts '------------'

    @cells = []
    9.times do |_i|
      @cells.push(Cell.new)
    end

    @turn = 0
    @winner = ''
    @game_won = false

    game_start
  end

  def draw_board
    cls
    puts '------------'
    puts [[" #{@cells[0].output} | #{@cells[1].output} | #{@cells[2].output} "],
          [" #{@cells[3].output} | #{@cells[4].output} | #{@cells[5].output} "],
          [" #{@cells[6].output} | #{@cells[7].output} | #{@cells[8].output} "]]
    puts '------------'
  end

  def game_start
    player_turn(@player1)
    while @turn <= 8 && @game_won == false
      if @turn.odd?
        player_turn(@player2)
      else
        player_turn(@player1)
      end
    end
    game_end
  end

  def game_end
    if @winner == @player1
      puts "#{@player1} won the game!"
    elsif @winner == @player2
      puts "#{@player1} won the game!"
    else
      puts 'Draw!'
    end
    new_game
  end

  def player_turn(player)
    if player == @player1
      puts "#{player} enter position for 'X' (from 1-9):"
      input = gets.chomp
      while input.match?(/[^1-9]/) || input.length > 1 || input.nil? || @cells[input.to_i - 1].state != 0
        puts 'Wrong input:' if @cells[input.to_i - 1].state.zero?
        puts 'Spot was already taken' if @cells[input.to_i - 1].state != 0
        input = gets.chomp
      end
      @cells[input.to_i - 1].turn('x')
    else
      puts "#{player} enter position for 'O' (from 1-9):"
      input = gets.chomp
      while input.match?(/[^1-9]/) || input.length > 1 || input.nil? || @cells[input.to_i - 1].state != 0
        puts 'Wrong input:' if @cells[input.to_i - 1].state.zero?
        puts 'Spot was already taken' if @cells[input.to_i - 1].state != 0
        input = gets.chomp
      end
      @cells[input.to_i - 1].turn('o')
    end
    @turn += 1
    draw_board
    check_win
  end

  def check_win
    WINNING_COMBINATIONS.each do |i|
      if @cells[i[0]].state == 1 && @cells[i[1]].state == 1 && @cells[i[2]].state == 1
        @game_won = true
        @winner = @player1
      elsif @cells[i[0]].state == 2 && @cells[i[1]].state == 2 && @cells[i[2]].state == 2
        @game_won = true
        @winner = @player2
      end
    end
  end
end

def cls
  system('cls') || system('clear')
end

def new_game
  puts 'Start a new game? (Y/n)'
  input = gets.chomp
  if input.downcase != 'y'
    puts 'Thanks for playing!'
    sleep(1)
    cls
  else
    Game.new
  end
end

new_game
