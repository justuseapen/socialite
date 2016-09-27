class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, 
         :validatable, :omniauthable

  has_one :buffer_account
  has_many :lists
  has_many :buffer_profiles, through: :buffer_account

  def buffer_connected?
    self.buffer_account.present?
  end 

  def connect_with_buffer(auth)
    @buffer_account = BufferAccount.new
    @buffer_account.user_id = self.id
    @buffer_account.uid = auth.uid
    @buffer_account.access_token = auth.credentials.token
    @buffer_account.pull_and_save_profiles
    @buffer_account.save
    @user = @buffer_account.user
  end

end
