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
    validate_user_info
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

  def validate_user_info
    raise ArgumentError, 'No spaces allowed in username!' if
    user_info.username.include? ' '
    raise ArgumentError, 'No spaces allowed in password!' if
    user_info.password.include? ' '
  end
end

# File.open('users.yml', 'a') do |file|
#       file.puts(input)
#    end
