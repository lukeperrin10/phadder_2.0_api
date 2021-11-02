# frozen_string_literal: true

module ServiceRequestFilteringService
  def self.by_state_category_location(user)
    service_provider_category_ids = user.service_provider.categories.map(&:id)
    collection = ServiceRequest.with_states(:new, :pending)
                               .joins(:categories)
                               .where('categories.id': service_provider_category_ids)
    collection.to_ary.keep_if do |request|
      Address.near(request.address).select('id').map(&:service_provider_id).include?(user.service_provider.id)
    end
  end
end
