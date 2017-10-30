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
end

# open('users.yml', 'w').write ''
#     user.change_name('bob')
#    user.change_pass('easy')
#   user.create
#  expect(File.read('users.yml')).to match 'bob easy'
