class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content, type: String

  belongs_to :commentable, polymorphic: true
  belongs_to :user
end
