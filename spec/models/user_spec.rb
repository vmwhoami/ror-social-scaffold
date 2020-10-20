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

 context "Should return all the accepted friends" do
   before(:each) do
     u_1 = User.create(name:'user1',email:"test1@mail.com",password:"password") 
     u_2 = User.create(name:'user2',email:"test2@mail.com",password:"password") 
    #  u_1.friendships.create(friend:)
   end
 end
 
 
end
