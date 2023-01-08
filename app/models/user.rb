class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  def to_s
    email
  end
  
  after_create do
    customer = Stripe::Customer.create(email: email)
    update(stripe_customer_id: customer.id)
  end

  def self.from_omniauth(access_token)
    user = User.where(email: access_token.info.email).first
    unless user
        user = User.create(
           email: access_token.info.email,
           password: Devise.friendly_token[0,20]
        )
    end
    user.name = access_token.info.name
    user.image = access_token.info.image
    user.uid = access_token.uid
    user.provider = access_token.provider
    user.save

    user
end
  
end
