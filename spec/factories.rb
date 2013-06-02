FactoryGirl.define do
	factory :alert do
		sequence(:title) { |n| "title#{n}" }
		sequence(:body) { |n| "body#{n}" }
	end
	
	factory :location do
		sequence(:name) { |n| "location#{n}" }
	end
	
	factory :user do
		sequence(:username) { |n| "username#{n}" }
		sequence(:password) { |n| "password#{n}" }
		location
	end
	
	factory :applicant do
		user
		sequence(:name) { |n| "applicant#{n}" }
	end
	
	factory :decision do
		sequence(:number) { |n| n }
	end
	
	factory :request do
		applicant
		
		factory :pending_request do
			accepted nil
		end
		factory :accepted_request do
			#decision
			accepted true
		end
		factory :rejected_request do
			accepted false
		end
	end
	
	factory :coming do
		sequence(:reason) { |n| "reason#{n}" }
		
		factory :pending_coming do
			association :request, factory: :pending_request, rtype: Coming::Type
		end
		factory :accepted_coming do
			association :request, factory: :accepted_request, rtype: Coming::Type
		end
		factory :rejected_coming do
			association :request, factory: :rejected_request, rtype: Coming::Type
		end
	end
	
	factory :leave do
		sequence(:reason) { |n| "reason#{n}" }
		
		factory :pending_leave do
			association :request, factory: :pending_request, rtype: Leave::Type
		end
		factory :accepted_leave do
			association :request, factory: :accepted_request, rtype: Leave::Type
		end
		factory :rejected_leave do
			association :request, factory: :rejected_request, rtype: Leave::Type
		end
	end
	
	factory :ticket do
		sequence(:line) { |n| "line#{n}" }
		
		factory :pending_ticket do
			association :request, factory: :pending_request, rtype: Ticket::Type
		end
		factory :accepted_ticket do
			association :request, factory: :accepted_request, rtype: Ticket::Type
		end
		factory :rejected_ticket do
			association :request, factory: :rejected_request, rtype: Ticket::Type
		end
	end
	
	factory :vacation do
		sequence(:duration) { |n| "#{n}1" }
		sequence(:from) { |n| "#{n}2" }
		sequence(:to) { |n| "#{n}3" }
		
		factory :pending_vacation do
			association :request, factory: :pending_request, rtype: Vacation::Type
		end
		factory :accepted_vacation do
			association :request, factory: :accepted_request, rtype: Vacation::Type
		end
		factory :rejected_vacation do
			association :request, factory: :rejected_request, rtype: Vacation::Type
		end
	end
end