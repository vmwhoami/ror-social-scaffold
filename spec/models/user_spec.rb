require 'rails_helper'

RSpec.describe User, type: :model do
  context 'User creation' do
    it 'should validate precense of name' do
      user = User.new(email: 'test@mail.com', password: 'password').save
      expect(user).to eq(false)
    end
    it 'should validate precense of name' do
      user = User.new(name: 'test', email: 'test@mail.com', password: 'password').save
      expect(user).to eq(true)
    end
  end

  context 'Make friendship' do
    before(:each) do
      @user_one = User.create(name: 'user1', email: 'test1@mail.com', password: 'password')
      @user_two = User.create(name: 'user2', email: 'test2@mail.com', password: 'password')
      @user_one.friendships.create(friend: @user_two)
    end

    it 'should have incoming friend requests' do
      expect(@user_two.pending_friends.count).to eq(1)
    end

    it 'should accept friend requests' do
      @user_two.accept_friend(@user_one)
      expect(@user_one.friends.count).to eq(1)
    end

    it 'Friends increase in the opite direction' do
      @user_two.accept_friend(@user_one)
      expect(@user_two.friends.count).to eq(1)
    end
    it 'Should be able to reject friends' do
      @user_two.reject(@user_one)
      expect(@user_two.pending_friends.count).to eq(0)
    end

    it 'Should be able to tell if a friend is a friend' do
      @user_two.accept_friend(@user_one)
      expect(@user_two.friend?(@user_one)).to eq(true)
    end
  end
end
