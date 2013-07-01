class User < ActiveRecord::Base
	PROTECTED = false
	INCLUDES_FIND  = { requests: :applicant, applicants: :requests, location: nil }
	INCLUDES_ALL = [:requests, :applicants, :location]

	attr_accessible :admin, :location, :location_attributes, :location_id,
	:password, :username

	has_secure_password

	belongs_to :location
	delegate :name, to: :location, prefix: true

	has_many :applicants, dependent: :destroy
	has_many :requests, through: :applicants

	accepts_nested_attributes_for :location

	validates :username, presence: true #, uniqueness: { case_sensetive: false, case_insensetive: true }
	
	def self.login(login)
		username, password = login[:username], login[:password]
		user = User.where("lower(username) = ?", username.downcase).first
		user.authenticate password if user
	end

	def self.authenticate(user, record)
		(record.try(:user) == user) or user.try(:admin)
	end
end
