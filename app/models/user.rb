# == Schema Information
#
# Table name: users
#
#  id             :bigint           not null, primary key
#  comments_count :integer
#  likes_count    :integer
#  private        :boolean
#  username       :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class User < ApplicationRecord
end
