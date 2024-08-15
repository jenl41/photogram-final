# == Schema Information
#
# Table name: photos
#
#  id             :bigint           not null, primary key
#  caption        :text
#  comments_count :integer
#  image          :string
#  likes_count    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  owner_id       :integer
#
class Photo < ApplicationRecord
  validates(:poster, { :presence => true })
  belongs_to(:poster, class_name: "User", foreign_key: "owner_id")

  def poster
    my_owner_id = self.owner_id

    matching_users = User.where({ :id => my_owner_id })

    the_user = matching_users.at(0)

    return the_user
  end

  

  # Photo#comments: returns rows from the comments table associated to this photo by the photo_id column
  has_many(:comments, class_name: "Comment", foreign_key: "photo_id")

  # Photo#likes: returns rows from the likes table associated to this photo by the photo_id column
  has_many(:likes, class_name: "Like", foreign_key: "photo_id")
  
  ## Indirect associations

  # Photo#fans: returns rows from the users table associated to this photo through its likes
  has_many(:fans, through: :likes, source: :fan)

end
