class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :company
  has_many :requests
  has_many :exchanges
  has_many :orders, dependent: :destroy
  has_many :memberships, through: :orders

  has_one_attached :avatar

  validates :first_name, presence: true
  validates :first_name, length: { minimum: 3 }
  # validates :first_name, format: { with: /[a-zA-Z\u00C0-\u00FF ]/i }

  validates :last_name, presence: true
  validates :last_name, length: { minimum: 2 }
  # validates :last_name, format: { with: /[a-zA-Z\u00C0-\u00FF ]/i }

  validates :email, presence: true, uniqueness: true
  # validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i }

  validates :cpf, presence: false, uniqueness: false
  # validate :valid_cpf
  # validates :CPF, format: { with: /\A\d{3}\.\d{3}\.\d{3}\-\d{2}\Z/ }

  validates :re, presence: false, uniqueness: false

  # validates :RE, format: { with: /\d+/ }

  validates :phone, presence: true, uniqueness: true
  # validates :phone, format: { with: /(\d{2})(\d{2})(\d{1})(\d{4})(\d{4})/ }

  #after_create :send_welcome_email

  private

  def send_welcome_email
    UserMailer.with(user: self).welcome.deliver_now
  end

  def valid_cpf
    invalid = %w[12345678909 11111111111 22222222222 33333333333 44444444444 55555555555 66666666666 77777777777 88888888888 99999999999 00000000000 12345678909]
    value = cpf.scan(/[0-9]/)
    if value.length == 11 && !invalid.member?(value.join)
      value = value.map(&:to_i)
      sum = (10 * value[0]) + (9 * value[1]) + (8 * value[2]) + (7 * value[3]) + (6 * value[4]) + (5 * value[5]) +
            (4 * value[6]) + (3 * value[7]) + (2 * value[8])
      sum -= 11 * (sum / 11)
      result1 = sum.zero? || sum == 1 ? 0 : 11 - sum
      if result1 == value[9]
        sum = (value[0] * 11) + (value[1] * 10) + (value[2] * 9) + (value[3] * 8) + (value[4] * 7) + (value[5] * 6) +
              (value[6] * 5) + (value[7] * 4) + (value[8] * 3) + (value[9] * 2)
        sum -= 11 * (sum / 11)
        result2 = sum.zero? || sum == 1 ? 0 : 11 - sum
        return if result2 == value[10] # CPF válido
      end
    end
    errors.add(:cpf, 'inválido')
  end
end
