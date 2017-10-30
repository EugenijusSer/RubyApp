require 'spec_helper'

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
    it 'warns if there is spaces in username' do
      expect { user.create('bo b', 'west') }.to raise_error(
        ArgumentError, 'No spaces allowed in username!'
      )
    end

    it 'warns if there is spaces in password' do
      expect { user.create('bob', 'w e st') }.to raise_error(
        ArgumentError, 'No spaces allowed in password!'
      )
    end
  end
end

# open('users.yml', 'w').write ''
#     user.change_name('bob')
#    user.change_pass('easy')
#   user.create
#  expect(File.read('users.yml')).to match 'bob easy'
