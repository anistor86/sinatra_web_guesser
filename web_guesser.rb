require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(101)
@@remaining_guesses = 5

get '/' do
  if params["cheat"] == "true"
    cheat_message = "The secret number is: #{SECRET_NUMBER}"
  else
    cheat_message = "Good boy...you don't cheat!"
  end
  if params["guess"] != nil
    @@remaining_guesses -= 1
    if @@remaining_guesses > 0
      guess = params["guess"].to_i
      if check_guess(guess) == "You got it right! The number was #{SECRET_NUMBER}"
        @@remaining_guesses = 5
        message = check_guess(guess) + "<br />Number changed, play again!"
        cheat_message = "Congrats! You cheater!"
        background = check_background(message)
        SECRET_NUMBER = rand(101)
      else
        message = check_guess(guess)
        background = check_background(message)
      end
    elsif @@remaining_guesses == 0
      SECRET_NUMBER = rand(101)
      @@remaining_guesses = 5
      background = "#FF1A1A"
      message = "No more lives! You lose, number changed! Play again!"
    end
  else
    background = "#FF1A1A"
  end
  erb :index, :locals => {:number => SECRET_NUMBER, :message => message, :bgcolor => background, :remaining_guesses => @@remaining_guesses, :cheat_message => cheat_message}

end

def check_guess(guess)
  if guess > SECRET_NUMBER + 5
    return "Way too high!"
  elsif guess < SECRET_NUMBER - 5
    return "Way too low!"
  elsif guess > SECRET_NUMBER
    return "Too high!"
  elsif guess < SECRET_NUMBER
    return "Too low!"
  elsif guess == SECRET_NUMBER
    return "You got it right! The number was #{SECRET_NUMBER}"
  end
end

def check_background(message)
  if message == "Way too high!" || message == "Way too low!"
    return "#FF1A1A"
  elsif message == "Too high!" || message == "Too low!"
    return "#FF4D4D"
  else
    return "#33CC33"
  end
end
