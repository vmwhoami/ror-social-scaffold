require 'rails_helper'

RSpec.describe User, type: :model do
 context "User creation" do
  it "should validate precense of name" do
    user = User.new(email:"test@mail.com",password:"password").save
    expect(user).to eq(false)
  end
  it "should validate precense of name" do
    user = User.new(name:"test",email:"test@mail.com",password:"password").save
    expect(user).to eq(true)
  end
 end

 context "Make friendship" do
   before(:each) do
     @u_1 = User.create(name:'user1',email:"test1@mail.com",password:"password") 
     @u_2 = User.create(name:'user2',email:"test2@mail.com",password:"password") 
     @u_1.friendships.create(friend:@u_2)
   end

   it "should have incoming friend requests" do
     expect(@u_2.pending_friends.count).to eq(1) 
   end

  it "should accept friend requests" do
    @u_2.accept_friend(@u_1)
    expect(@u_1.friends.count).to eq(1)
  end
   
  it "Friends increase in the opite direction" do
    @u_2.accept_friend(@u_1)
    expect(@u_2.friends.count).to eq(1)
  end
  it "Should be able to reject friends" do
    @u_2.reject(@u_1)
    expect(@u_2.pending_friends.count).to eq(0)
  end
   
  it "Should be able to tell if a friend is a friend" do
    @u_2.accept_friend(@u_1)
    expect(@u_2.friend?(@u_1)).to eq(true)
  end

 end
 
 
end
