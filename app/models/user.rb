class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  validates :name, :surname, presence: true

  validate :password_validation

  private

  def password_validation
    return if uppercase?(password) && lowercase?(password) && number?(password)

    errors.add :password, 'must have at least one uppercase letter, one lowercase letter and one number'
  end

  def uppercase?(password)
    password.match(/[A-Z]{1}/)
  end

  def lowercase?(password)
    password.match(/[a-z]{1}/)
  end

  def number?(password)
    password.match(/[0-9]{1}/)
  end
end
