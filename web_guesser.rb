require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(101)
get '/' do

  if params["guess"] != nil
    guess = params["guess"].to_i
    message = check_guess(guess)
  end
  erb :index, :locals => {:number => SECRET_NUMBER, :message => message}

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
