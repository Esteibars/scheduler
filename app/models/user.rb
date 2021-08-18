class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  validates :name, :surname, presence: true
  
  validate :password_validation

  private

  def password_validation
      if !password.match(/[A-Z]{1}/) || !password.match(/[a-z]{1}/) || !password.match(/[0-9]{1}/)
        errors.add :password, 'must have at least one uppercase letter, one lowercase letter and one number'
      end
  end
end
