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

   it "should have outgoing friend requests" do
     expect(@u_1.outgoing_friend_requests.count).to eq(1) 
   end

   
   it "should have incoming friend requests" do
    expect(@u_2.incoming_friend_requests.count).to eq(1) 
  end

  it "should accept friend requests" do
    @u_2.accept_friend(@u_1)
    expect(@u_1.friends.include?(@u_2)).to eq(true)
  end
   
 end
 
 
end
