require 'jeweler/connection'
require 'jeweler/writeable'
require 'jeweler/resource'
require 'jeweler/singleton_resource'
require 'jeweler/finders'
require 'jeweler/collection'
require 'jeweler/errors'
require 'jeweler/json_api'
require 'jeweler/util'

module Jeweler
  module Client
    extend ActiveSupport::Concern
    include Jeweler::Connection

    included do
      extend Client::ClassMethods
      extend Jeweler::Util
    end

    module ClassMethods
      cattr_reader :base_collection

      def base_collections(*collections)
        collections.each do |collection|
          define_method collection do
            if instance_variable_defined?(:"@#{collection}")
              return instance_variable_get(:"@#{collection}")

            else
              resource_klass = self.class.const_in_current_namespace(collection.to_s)

              instance_variable_set(:"@#{collection}",
                Jeweler::Collection.new(self, -> { self.perform_request(:get, resource_klass.path_for_index) }, resource_klass)
              )
            end
          end
        end
      end
    end

    # This method is called whenever JSON data from the API is put into one of
    # our objects. If some transformation has to take place, this method can be
    # overwritten to ensure the data is normalised to the attributes we want
    def normalize_data(data)
      data
    end

    def interface_style
      :rails
    end
  end
end
