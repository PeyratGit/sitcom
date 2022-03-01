class TvShow < ApplicationRecord
  has_many :feedbacks, dependent: :destroy
  has_many :wishes, dependent: :destroy
end
