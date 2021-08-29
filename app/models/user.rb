class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  validates :name, :surname, presence: true

  validate :password_validation

  private

  def password_validation
    if !(has_uppercase?(password) && has_lowercase?(password) && has_number?(password))
      errors.add :password, 'must have at least one uppercase letter, one lowercase letter and one number'
    end
  end

  def has_uppercase?(password)
    password.match(/[A-Z]{1}/)
  end

  def has_lowercase?(password)
    password.match(/[a-z]{1}/)
  end

  def has_number?(password)
    password.match(/[0-9]{1}/)
  end
end
