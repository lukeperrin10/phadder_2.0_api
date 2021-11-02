# frozen_string_literal: true

class Categories::ShowSerializer < ActiveModel::Serializer
  attributes :id, :name
  # attribute 

  # def translations
  #   translations = []
  #   object.translations.each do |translation|
  #     translations.push(
  #       locale: translation.locale,
  #       name: translation.name
  #     )
  #   end
  #   translations
  # end
end
