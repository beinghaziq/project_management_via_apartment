class User < ApplicationRecord
	after_save :create_tenat

	private

	def create_tenat
		Apartment::Tenant.create(subdomain)
	end
end
