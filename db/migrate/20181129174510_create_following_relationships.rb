# This seems to be the missing migration that needs to be created during the video
# at 7:25.
# I started with:
#
#   rails g model FollowingRelationship follower_id:integer followed_user_id:integer
#
# But then edited to reflect the changes below. I'm not sure if there's a syntax for the
# model migration that creates the belongs_to methods right off the bat.
class CreateFollowingRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :following_relationships do |t|
      t.belongs_to :follower
      t.belongs_to :followed_user
      t.timestamps
    end
  end
end
