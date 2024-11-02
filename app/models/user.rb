class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i }
  validates :password_confirmation, presence: true

  # お名前（全角）は名字と名前が必須で、全角（漢字・ひらがな・カタカナ）のみ許容
  validates :first_name, presence: true, format: { with: /\A[一-龥ぁ-ゔァ-ヴー]+\z/ }
  validates :family_name, presence: true, format: { with: /\A[一-龥ぁ-ゔァ-ヴー]+\z/ }

  # お名前カナ（全角）は名字と名前が必須で、全角カタカナのみ許容
  validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }
  validates :family_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/ }

  # 生年月日は必須
  validates :birth_date, presence: true
end
