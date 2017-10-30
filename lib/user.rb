require_relative 'recipe'
# Class responsible for user creating, loging in, etc.
class User
  attr_reader :user_info, :users

  # contains user name and password
  UserInfo = Struct.new :username, :password

  def initialize
    @users = []
  end

  def create(username, password)
    @user_info = UserInfo.new(username, password)

    if already_exists?(username)
      puts 'User with this username already exists'
    else
      users.push(user_info)
    end
  end

  def already_exists?(username)
    users.map! do |user|
      return true if user.username.eql?(username)
    end
    false
  end
end

# File.open('users.yml', 'a') do |file|
#       file.puts(input)
#    end
