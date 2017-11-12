require_relative './lib/recipe'
require_relative './lib/user'

# simple ui
class Interface
  user = User.new

  def self.main_program(user)
    puts '1. Add recipe'
    puts '2. Display all recipes'
    loop do
      puts "\nType selection"
      input = gets.chomp
      case input
      when '1'
        puts 'enter id'
        id = gets.chomp
        puts 'enter name'
        name = gets.chomp
        user.add_recipe(id, name)
      when '2'
        user.display_recipes
      when '0'
        break
      end
    end
  end

  puts "\nMenu:"
  puts '1. Create user'
  puts '2. Login'
  puts '3. Save users'
  puts '4. Load users'
  puts '5. Display all users'

  loop do
    puts "\nType selection"
    input = gets.chomp
    case input
    when '1'
      puts 'enter username'
      username = gets.chomp
      puts 'enter password'
      password = gets.chomp
      begin
        user.create(username, password)
      rescue ArgumentError => e
        puts e.message
      end
    when '2'
      puts 'enter username'
      username = gets.chomp
      puts 'enter password'
      password = gets.chomp
      begin
        user.login(username, password)
      rescue ArgumentError => e
        puts e.message
      end
      if user.log_in == true
        main_program(user)
        break
      end
    when '3'
      user.save
    when '4'
      user.load
    when '5'
      user.display_users
    when '0'
      break
    end
  end
end
