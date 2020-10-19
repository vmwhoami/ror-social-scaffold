require 'rails_helper'

RSpec.describe User, type: :model do
 context "User creation" do
  it "should validate precense of name" do
    user = User.new(email:"vmwhoami@gmail.com",password:"password").save
    expect(user).to eq(false)
  end
 end

 context "Users should have friends" do
   before(:each) do
    User.delete_all
    @user_1 = User.create!(name:"test_1",email:"test_1@mail.com",password:"password")
    @user_2 = User.create!(name:"test_2",email:"test_2@mail.com",password:"password")
   end
   
   it "should have no friend " do
     expect(@user_1.friends.size).to eq(0)  
   end
   
   it "should have no friend " do
    f = @user_1.friendships.new
    f.friend = @user_2
    expect(@user_1.pending_friends.size).to eq(1)  
  end
  
 end
 
 
end
