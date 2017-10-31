require 'spec_helper'
require 'fileutils'
describe User do
  let(:user) { described_class.new }

  context 'on create' do
    it 'is saved to users array' do
      user.create('bob', 'west')
      expect(user.users[0]).to have_attributes(
        username: 'bob', password: 'west'
      )
    end

    it 'warns if there is already user with selected username' do
      user.create('bob', 'one')
      expect { user.create('bob', 'two') }.to output(
        "User with this username already exists\n"
      ).to_stdout
    end

    it 'searches for already existing users' do
      user.create('bob', 'west')
      expect(user.already_exists?('john')).to eq false
    end
  end

  context 'user info validation' do
    it 'raises error if there is spaces in username' do
      expect { user.create('bo b', 'west') }.to raise_error(
        ArgumentError, 'No spaces allowed in username!'
      )
    end

    it 'raises error if there is spaces in password' do
      expect { user.create('bob', 'w e st') }.to raise_error(
        ArgumentError, 'No spaces allowed in password!'
      )
    end
  end

  context 'bad login info' do
    it 'warns if there is no such user' do
      user.create('bob', 'one')
      expect { user.login('john', 'three') }.to output(
        "There is no such user registered\n"
      ).to_stdout
    end

    it 'raiser error if entered password is wrong' do
      user.create('bob', 'one')
      expect { user.login('bob', 'onee') }.to raise_error(
        ArgumentError, 'Wrong password!'
      )
    end

    it 'checks user list for entered user info' do
      user.create('bob', 'west')
      expect(user.find_user('john')).to eq false
    end
  end

  context 'log in status' do
    it 'set to false on initialize' do
      expect(user.log_in). to eq false
    end

    it 'set to true after login' do
      user.create('bob', 'one')
      user.login('bob', 'one')
      expect(user.log_in).to eq true
    end
  end

  context 'users' do
    before do
      user.clear_user_list
      user.create('bobby', 'house')
      user.create('john', 'wall')
      user.create('abc', 'def')
      open('users.yml', 'w+').write('')
      user.save
    end

    it 'can be saved to file users.yml' do
      actual = 'users.yml'
      expect(actual).to be_identical_file_as('expected_users.yml')
    end

    it 'clears user list before tests' do
      user.clear_user_list
      expect(user.users).to eq []
    end

    it 'can be loaded from file users.yml' do
      user.clear_user_list
      user.load
      expected_users = YAML.load_file('expected_users.yml')
      expect(user.users).to eq expected_users
    end
  end

  context 'recipe' do
    before do
      user.add_recipe('re243234', 'sandwich')
    end
    it 'can add id and name' do
      expect(user.recipes[0]).to eq(id: 're243234', name: 'sandwich')
    end

    it 'can add nutrition' do
      user.add_nutrition(20, 50, 30)
      expect(user.recipes[0]).to have_correct_recipe_values(
        're243234', 'sandwich', 20, 50, 30
      )
    end

    it 'can all be displayed' do
      user.add_recipe('uiw2323', 'cake')
      expect { user.display_recipes }.to output(
        "re243234\nsandwich\nuiw2323\ncake\n"
      ).to_stdout
    end
  end
end
