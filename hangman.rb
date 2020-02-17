
# Selects a word for game
def select_word
#  print("Enter a dictionary file name: ")
#  filename = gets.chomp()
  filename = "dictionary.txt"
  lexicon = File.open(filename)

  words = lexicon.readlines do each |line|
    if line >= 5 || line <=12
      line
    end
  end

  index = rand(words.length - 1)
  gameword = words[index].chomp()
end

def game_over?
  (@turns == 0) || (@players_word.eql?(@gameword))
end

def play_game
  puts "You have #{@turns} turns left."
  puts "Your word is #{@players_word}"
  print "Enter a letter: "
  letter = gets.chomp();

  # Length validation
  if (letter.length > 1)
    puts "Invalid input"
    play_game
  end

  # Checks if letter is in word
  if /#{letter.upcase}/ =~ @gameword
    for i in 0...@wordLength
      if (@gameword[i] == letter.upcase) && (@players_word[i] == "_")
        @players_word[i] = letter.upcase
      elsif @gameword[i] == letter.upcase
        puts "You already used that letter"
        play_game
      end
    end
  else
    @turns -= 1
    @used_letters << letter.upcase << ","
  end
  puts "The incorrect letters you have used are: " << @used_letters
end

# Setting game up
puts "Welcome to Hangman"
@gameword = select_word
@wordLength = @gameword.length
@players_word = ""
@used_letters = ""
@turns = 8

for i in 0...@wordLength
  @players_word = @players_word << "_"
end

# Play
while !game_over?
  play_game
end

puts "Game Over"
puts "The word was: " << @gameword
if @turns > 0
  puts "You Win"
else
  puts "You Lose"
end
