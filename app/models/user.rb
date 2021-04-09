class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :purchase_records

  VALID_KATAKANA_REGEX = /\A[ア-ン゛゜ァ-ォャ-ョー「」、]+\z/
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  VALID_ZENKAKU_REGEX = /\A[ぁ-んァ-ヶー一-龠]+\z/

  validates :nickname,           presence: true
  validates :password, format: { with: VALID_PASSWORD_REGEX, message: 'は半角英数字混合で入力して下さい' }
  validates :last_name,          presence: true, format: { with: VALID_ZENKAKU_REGEX, message: 'は全角（漢字・ひらがな・カタカナ）で入力して下さい' }
  validates :first_name,         presence: true, format: { with: VALID_ZENKAKU_REGEX, message: 'は全角（漢字・ひらがな・カタカナ）で入力して下さい' }
  validates :kana_last_name,     presence: true, format: { with: VALID_KATAKANA_REGEX, message: 'は全角（カタカナ）で入力して下さい' }
  validates :kana_first_name,    presence: true, format: { with: VALID_KATAKANA_REGEX, message: 'は全角（カタカナ）で入力して下さい' }
  validates :birthday,           presence: true
end
