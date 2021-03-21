class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname,        presence: true
  validates :email,           uniqueness: true
  validates :password,        format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i }
  validates :last_name,       presence: true
  validates :first_name,      presence: true
  validates :kana_last_name,  presence: true
  validates :kana_first_name, presence: true
  validates :birthday,        presence: true
end
