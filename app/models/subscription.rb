class Subscription
  include Mongoid::Document
  include Mongoid::Timestamps

  STATUS = [ :pending, :confirmed, :banned ]

  field :status, type: Symbol
  auto_increment :identifier

  has_one :army, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  belongs_to :tournament
  belongs_to :user

  validates_presence_of :status
  validates_presence_of :tournament
  validates_presence_of :user

  validates_inclusion_of :status, in: STATUS
  validates_inclusion_of :status, in:[ :pending ], on: :create

  validates_uniqueness_of :user, scope: :tournament
end
