class Identity
  include Mongoid::Document
  include Mongoid::Timestamps

  field :provider, type: String
  field :uid, type: String

  validates_presence_of :provider
  validates_presence_of :uid

  belongs_to :user

  def self.find_or_create_by_oauth( oauth )
    find_or_create_by( provider: oauth[:provider], uid: oauth[:uid] )
  end
end
