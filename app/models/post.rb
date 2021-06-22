class Post < ApplicationRecord
    belongs_to :user
    has_many :comments

    validates :tags, presence: true
end
