class User < ActiveRecord::Base
	has_many :todos

	validates :name, :email, :password, presence: true
end
