class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, # :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  before_validation :set_password

  # just a dummy method for admin
  def admin?
    self.id == 1
  end

  private
  def set_password
    if self.new_record?
      self.password = email.split('@')[0]
    end
  end
end
