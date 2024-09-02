class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  include UserRolesEnum
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :memberships
  acts_as_tenant :organization, through: :memberships, optional: true

  def generate_jwt
    JWT.encode({ id: id, exp: 1.day.from_now.to_i, jti: jti }, Rails.application.credentials.development.devise_jwt_secret_key!)
  end
end
