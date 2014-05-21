class Tournament
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  MINIMUM_PLAYERS = 4

  field :title,        type: String
  field :description,  type: String
  field :web,          type: String
  field :date,         type: DateTime
  field :sign_up_date, type: DateTime
  field :address,      type: String
  field :max_users,    type: Integer

  has_mongoid_attached_file :poster,
    styles: {
      original: ['1920x1680>', :jpg],
      small:    ['100x100#',   :jpg],
      medium:   ['250x250',    :jpg],
      large:    ['500x500>',   :jpg]
    },
    convert_options: {
      all: '-background white -flatten +matte'
    }

  field :remove_poster, type: String

  belongs_to :user
  has_many :subscriptions

  validates_presence_of :title
  validates_presence_of :date
  validates_presence_of :sign_up_date
  validates_presence_of :address
  validates_presence_of :max_users
  validates_presence_of :user

  validates_numericality_of :max_users,
    greater_than_or_equal_to: MINIMUM_PLAYERS,
    even: true
  validates_datetime :date,
    on_or_after: :today

  validates_datetime :sign_up_date,
    on_or_before: :date

  before_save do
    self.poster = nil if remove_poster == 'true'
  end

end
