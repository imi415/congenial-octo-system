class Channel < ApplicationRecord
  belongs_to :user
  attr_accessor :status
end
