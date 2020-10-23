require 'rails_helper'

RSpec.feature 'AddUserFrpmViews', type: :feature do
  context 'A user should be able to add friend from all users page' do
    before(:each) do
      @user_one = User.create!(name: 'user_one', email: 'user_one@mail.com', password: 'password')
      @user_two = User.create!(name: 'user_two', email: 'user_two@mail.com', password: 'password')
      visit '/users/sign_in'
      fill_in 'Email', with: 'user_one@mail.com'
      fill_in 'Password', with: 'password'
      click_button 'Log in'
      visit users_path
    end

    it 'checks if all users path has the add friend button' do
      expect(page).to have_link('Add Friend')
    end

    it 'Add friend button properly working' do
      click_link 'Add Friend'
      expect(@user_two.pending_friends.count).to eq(1)
    end
  end
end
