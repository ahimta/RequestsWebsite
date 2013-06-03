FactoryGirl.define do
	factory :ticket do
		sequence(:line) { |n| "line#{n}" }
			association :request, rtype: Ticket::Type

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
end