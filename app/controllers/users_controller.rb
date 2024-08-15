class UsersController < ApplicationController
  def index
    matching_users = User.all

    @list_of_users = matching_users.order({ :username => :asc, :created_at => :desc })

    render({ :template => "users/index" })
  end

  def show

    url_username= params.fetch("path_username")
    matching_usernames = User.where({ :username => url_username})
    @the_user = matching_usernames.first
  
    #if @the_user == nil
     # redirect_to("/")
   # else
   # render ({:template => "user_templates/details"})
   # end
  end

  def create
    the_user = User.new
    the_user.comments_count = params.fetch("query_comments_count")
    the_user.likes_count = params.fetch("query_likes_count")
    the_user.private = params.fetch("query_private", false)
    the_user.username = params.fetch("query_username")

    if the_user.valid?
      the_user.save
      redirect_to("/users", { :notice => "User created successfully." })
    else
      redirect_to("/users", { :alert => the_user.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_user = User.where({ :id => the_id }).at(0)

    the_user.comments_count = params.fetch("query_comments_count")
    the_user.likes_count = params.fetch("query_likes_count")
    the_user.private = params.fetch("query_private", false)
    the_user.username = params.fetch("query_username")

    if the_user.valid?
      the_user.save
      redirect_to("/users/#{the_user.id}", { :notice => "User updated successfully."} )
    else
      redirect_to("/users/#{the_user.id}", { :alert => the_user.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_user = User.where({ :id => the_id }).at(0)

    the_user.destroy

    redirect_to("/users", { :notice => "User deleted successfully."} )
  end

  def feed
    the_username = params.fetch("user_name")
    matching_users = User.where({ :username => the_username})


    render({ :template => "users/feed" })

  end

end
