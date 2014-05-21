class User
  include Mongoid::Document

  # Include default devise modules. Others available are:
  # :confirmable
  # :lockable
  # :timeoutable
  # :registerable
  # :database_authenticatable
  # :recoverable
  # :rememberable
  # :validatable
  # :token_authenticatable

  devise :omniauthable, :omniauth_providers => [ :github, :google_oauth2, :twitter ]
         :trackable

  ## Database authenticatable
  # field :email,              type: String, default: ""
  # field :encrypted_password, type: String, default: ""

  ## Recoverable
  # field :reset_password_token,   type: String
  # field :reset_password_sent_at, type: Time

  ## Rememberable
  # field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  field :email,  :type => String, :default => ''
  field :name,   :type => String, :default => ''
  field :nick,   :type => String, :default => ''
  field :avatar, :type => String, :default => ''

  validates_presence_of :name

  validates_uniqueness_of :email, if: :present?
  validates_format_of :email,
    with: Devise::email_regexp,
    allow_blank: true,
    if: :present?

  has_many :identities, dependent: :destroy
  has_many :tournaments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :comments

  def self.find_or_create_by_oauth( info )
    resource = where( email: info[:email] ).first if info[:email].present?
    resource || create( name: info[:name], email: info[:email], nick: info[:nickname], avatar: info[:image] )
  end

  def subscription_to( tournament )
    self.subscriptions.where( tournament: tournament ).first
  end
end
