# frozen_string_literal: true

require 'rest-client'
require 'active_model'
# require 'activemodel/serializers/xml'
# TODO: include strong_parameters?

module ActiveRest
  class Base
    include ActiveModel::AttributeMethods
    include ActiveModel::Serialization
    include ActiveModel::Serializers::JSON
    # include ActiveModel::Serializers::Xml

    def attributes=(hash)
      hash.each do |key, value|
        send("#{key}=", value)
      end
    end

    def attributes
      @attributes.to_hash
    end

    # def attributes
    #   {'name' => nil}
    # end

    def self.api(configurations)
      configurations.each do |key, value|
        define_singleton_method("api_#{key}") { nil }
        singleton_class.class_eval do
          remove_method("api_#{key}") if method_defined?("api_#{key}")
          define_method("api_#{key}") { value }
        end
      end
    end

    # method GET
    def self.all
      puts name.to_s + ' .all'
      # get
    end

    # method GET
    def self.find(id)
      puts name.to_s + ' .find ' + id
      # get("/#{id}")
    end

    # method POST
    def self.create(attrs = {})
      puts name.to_s + ' .create ' + attrs.inspect
    end

    # serialize the attrs and PUT
    # method PUT
    def update(attrs = {})
      puts name.to_s + ' .update ' + attrs.inspect
      resp = self.class.request(:put, "/#{id}", attrs)
      assign_attributes(resp)
    end

    # serialize the current state of all attributes
    # method PUT
    # def save
    #   puts name.to_s + ' .save'
    #   update(serialize)
    # end

    # method DELETE
    # def destroy
    #   puts name.to_s + ' .destroy'
    #   resp = self.class.delete("/#{id}")
    # end

    #
    # Wrapper method for the request methods of the same names
    #
    def self.get(tokens = '')
      resp = request(:get, tokens)
      return initialize_objects(resp) if resp.is_a?(Array)
      return initialize_object(resp) if resp.is_a?(Hash)
      raise 'Unknown response format'
    end

    def self.post(tokens = '', attrs)
      resp = request(:post, tokens, attrs)
      initialize_object(resp)
    end

    def self.put(tokens, attrs)
      request(:put, tokens, attrs)
    end

    def self.delete(tokens = '')
      request(:delete, tokens)
    end

    # def self.initialize_object(attrs)
    #   obj = new(attrs)
    #   obj.assign_attributes(attrs)
    # end
    #
    # def self.initialize_objects(attrs_arr)
    #   attrs_arr.map { |attrs| initialize_object(attrs) }
    # end

    def self.request(verb, tokens = '', params = nil)
      # puts "ApiClient::request #{verb},"\
      # " #{BASE_URL}#{path}, #{params}, #{headers}"
      path = method_defined?(:api_path) ? api_path : ''

      response = RestClient::Request.execute(
        method: verb,
        url: api_url + path + tokens,
        payload: params ? serialize(params) : to_json,
        headers: {
          content_type: 'application/json',
          accept: 'application/json'
        }.merge!(api_headers)
      )

      deserialize(response)
    end

    def assign_attributes(_values, _options = {})
      send("#{k}=", v)
    end

    def serialize(payload)
      # this may not always be json
      # payload.to_xml
      payload.to_json
    end

    def deserialize(payload)
      # this may not always be json
      # from_xml(payload)
      from_json(payload)
    end
  end
end
require_relative './active_rest/api_model'
require_relative './active_rest/concrete_example_model'
require_relative './active_rest/other_model'
