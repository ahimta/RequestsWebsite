class Leave < ActiveRecord::Base
	Type = 'leave'
	attr_accessible :reason, :request_attributes, :request_id


	belongs_to :request
	has_one :applicant, through: :request
	delegate :name, to: :applicant, prefix: true
	
	has_one :user, through: :applicant
	delegate :username, to: :user, prefix: true


	accepts_nested_attributes_for :request


	validates :request, presence: true
	validates :reason, presence: true
end
