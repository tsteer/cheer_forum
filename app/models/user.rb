class User < ApplicationRecord
  validates_presence_of :username, :email, :date_of_birth
end
