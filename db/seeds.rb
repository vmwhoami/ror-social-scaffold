

User.create!(name:"Vitalie",email:"vmwhoami@gmail.com",password:"password")
User.create!(name:"Olea",email:"olea@gmail.com",password:"password")
User.create!(name:"Adam",email:"adam@gmail.com",password:"password")
User.create!(name:"Galina",email:"galina@gmail.com",password:"password")
User.create!(name:"Filip",email:"filip@gmail.com",password:"password")
User.create!(name:"Filipash",email:"filipash@gmail.com",password:"password")
User.create!(name:"Dima",email:"dima@gmail.com",password:"password")

10.times do |f|
  User.create!(name:"user_#{f}",email:"user#{f}@gmail.com",password:"password")
end
puts "-"*200
puts "Users created"



12.times do |ids|
  ids+=1
  Post.create!(
    user:User.find_by(id:ids),
    content:"Annihilate? No. No violence. I won't stand for it. Not now, not ever, do you understand me?! I'm the Doctor, the Oncoming Storm - and you basically meant beat them in a football match, didn't you?
      The way I see it, every life is a pile of good things and bad things.…hey.…the good things don't always soften the bad things; but vice-versa the bad things don't necessarily spoil the good things and make them unimportant. Stop talking, brain thinking. Hush.
      They're not aliens, they're Earth…liens! Aw, you're all Mr. Grumpy Face today. You know how I sometimes have really brilliant ideas? I'm the Doctor, I'm worse than everyone's aunt. *catches himself* And that is not how I'm introducing myself."
    )
end
puts "-"*200
puts "Posts created"


7.times do |ids|
  ids+=1
  Comment.create!(
    user:User.find_by(id:ids),
    post:Post.find_by(id:ids),
    content: "Who taught you to write like that? You should learn english"
    )
end

7.times do |ids|
  ids+=1
  Comment.create!(
    user:User.first,
    post:Post.find_by(id:ids),
    content: "Really nice post you shmuck!"
    )
end

puts "-"*200
puts "Comments created"


12.times do |ids|
  ids+=1
  Like.create!(
    user:User.find_by(id:ids),
    post:Post.find_by(id:ids)
    )
end
12.times do |ids|
  ids+=1
  Like.create!(
    user:User.last,
    post:Post.find_by(id:ids)
    )
end
puts "-"*200
puts "Likes created"


6.times do |ids|
  ids+=2
  Friendship.create!(
    user:User.first,
     friend:User.find_by(id:ids)
     )
end

6.times do |ids|
  ids+=2
  Friendship.create!(
    user:User.second,
     friend:User.find_by(id:ids)
     )
end
puts "-"*200
puts "Friendships created"