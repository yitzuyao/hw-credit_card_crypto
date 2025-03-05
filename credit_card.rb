# frozen_string_literal: true

require_relative './luhn_validator'
require 'json'

# CreditCard class represents a credit card with validation capabilities
class CreditCard
  # TODO: include the LuhnValidator module
  include LuhnValidator

  # instance variables with automatic getter/setter methods
  attr_accessor :number, :expiration_date, :owner, :credit_network

  def initialize(number, expiration_date, owner, credit_network)
    # TODO: initialize the instance variables listed above
    @number = number
    @expiration_date = expiration_date
    @owner = owner
    @credit_network = credit_network
  end

  # returns json string
  def to_json(*_args)
    {
      # TODO: setup the hash with all instance vairables to serialize into json
      number: @number,
      expiration_date: @expiration_date,
      owner: @owner,
      credit_network: @credit_network
    }.to_json
  end

  # returns all card information as single string
  def to_s
    to_json
  end

  # return a new CreditCard object given a serialized (JSON) representation
  def self.from_s(card_s)
    # Deserializing a CreditCard object
    card_data = JSON.parse(card_s)

    # Create a new CreditCard object with the parsed data
    new(
      card_data['number'],
      card_data['expiration_date'],
      card_data['owner'],
      card_data['credit_network']
    )
  end

  # return a hash of the serialized credit card object
  def hash
    # TODO: implement this method
    #   - Produce a hash (using default hash method) of the credit card's
    #     serialized contents.
    #   - Credit cards with identical information should produce the same hash
    to_json.hash
  end

  # return a cryptographically secure hash
  def hash_secure
    # TODO: implement this method
    #   - Use sha256 to create a cryptographically secure hash.
    #   - Credit cards with identical information should produce the same hash
    Digest::SHA256.hexdigest(to_json)
  end
end
