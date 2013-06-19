class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username
  # attr_accessible :title, :body

  has_many :albums
  has_many :songs

  # Create the following relationship
  has_and_belongs_to_many :followings,
        :association_foreign_key => 'following_id',
        :class_name => 'User',
        :join_table => 'users_followings'
 
  # Create the follower relationship
  has_and_belongs_to_many :followers,
        :foreign_key => 'following_id',
        :association_foreign_key => 'user_id',
        :class_name => 'User',
        :join_table => 'users_followings'


  def self.with_reviews
    all.reject{|e| (e.albums.length + e.songs.length) == 0}
  end

end