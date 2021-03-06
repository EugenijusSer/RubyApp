require_relative 'recipe'
require 'yaml'
# Class responsible for user creating, loging in, etc.
class User
  attr_reader :user_info, :users, :log_in, :recipes

  # contains user name and password
  UserInfo = Struct.new :username, :password

  def initialize
    @users = []
    @log_in = false
    @recipes = []
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
    users.each do |user|
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

  def login(username, password)
    @user_info = UserInfo.new(username, password)
    if find_user(username)
      raise ArgumentError, 'Wrong password!' unless users.include? user_info
      @log_in = true
    else
      puts 'There is no such user registered'
    end
  end

  def find_user(username)
    users.each do |user|
      return true if user.username.eql?(username)
    end
    false
  end

  def clear_user_list
    @users = []
  end

  def save
    File.open('yml/users.yml', 'w') do |file|
      file.write(users.to_yaml)
    end
  end

  def load
    @users = YAML.load_file('yml/users.yml')
  end

  def add_recipe(id, name)
    recipes.push(id: id, name: name)
  end

  def add_nutrition(fat, carbs, protein)
    recipes[-1][:recipe] = Recipe.new(fat, carbs, protein)
  end

  def display_recipes
    recipes.each do |item|
      puts item.fetch(:id)
      puts item.fetch(:name)
    end
  end

  def display_users
    users.each do |user|
      puts user.username + ' - ' + user.password
    end
  end
end
