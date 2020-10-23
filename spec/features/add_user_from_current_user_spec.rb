require 'rails_helper'

RSpec.feature 'AddUserFromCurrentUsers', type: :feature do
  context 'a context' do
    before(:each) do
      @user_one = User.create!(name: 'user_one', email: 'user_one@mail.com', password: 'password')
      @user_two = User.create!(name: 'user_two', email: 'user_two@mail.com', password: 'password')
      visit '/users/sign_in'
      fill_in 'Email', with: 'user_one@mail.com'
      fill_in 'Password', with: 'password'
      click_button 'Log in'
      visit users_path
      click_link 'Add Friend'
      click_link 'Sign out'
      fill_in 'Email', with: 'user_two@mail.com'
      fill_in 'Password', with: 'password'
      click_button 'Log in'
      click_link 'user_two@mail.com'
    end

    it 'Curent user should have an accept button' do
      expect(page).to have_link('accept')
    end

    it 'Curent user should have an reject button' do
      expect(page).to have_link('reject')
    end

    it 'Curent user should have an accept button' do
      click_link 'accept'
      expect(@user_two.friend?(@user_one)).to eq(true)
    end
  end
end
