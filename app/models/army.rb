class Army
  include Mongoid::Document
  include Mongoid::Timestamps

  field :list, type: String

  belongs_to :subscription
end
