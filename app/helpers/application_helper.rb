module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to('Dislike!', post_like_path(id: like.id, post_id: post.id), method: :delete)
    else
      link_to('Like!', post_likes_path(post_id: post.id), method: :post)
    end
  end
 
  def add_friend_btn(user)
   if !current_user.friend?(user) && !current_user.sent_req?(user) 
    link_to('Add Friend', add_path(person_id: user.id),method: :post, class: 'add_friend_btn') 
   end
  end

  def add_friend_show(user)
    add_friend_btn(user) if current_user != user
  end

  def friends_header(user,content,tag,method=nil)
    if current_user == user && method.any?
   " <#{tag}>#{content}</#{tag}>".html_safe
    end
  end
def users_email(user,u)
  if current_user == user
    "<p class='post-comments'>#{u.email}</p>".html_safe
  end
end
  def accept(user,usr)
    if current_user == user
    link_to 'accept', accept_path(inviter_id: usr.id),method: :put, class: 'add_friend_btn'
    end
  end

 
  def reject(user,usr)
    if current_user == user
      link_to 'reject', destroy_path(delete_id: usr.id),method: :delete, class: 'reject_friend_btn'    end
  end
end
