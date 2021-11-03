class ServiceRequests::ShowSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :title, :details, :state, :created, :budget, :time_frame
  attribute :images
  #belongs_to :user, serializer: Users::ForServiceRequestSerializer
  has_many :categories, serializer: Categories::ShowSerializer

  def created
    object.created_at.to_date
  end

  def images
    images_to_return = []
    object.images.each do |image|
      images_to_return << if Rails.env.test?
                            { url: rails_blob_url(image) }
                          else
                            { url: image.service_url(expires_in: 1.hour, disposition: 'inline') }
                          end
    end
    images_to_return
  end
end
