class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :book
    accepts_nested_attributes_for :user

    validates :content, presence: true
    
end
