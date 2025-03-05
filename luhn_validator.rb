# frozen_string_literal: true

# Validates credit card number using Luhn Algorithm
module LuhnValidator
  # arguments: none
  # assumes: a local String called 'number' exists
  # returns: true/false whether last digit is correct
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i)
    # Extract the check digit (last digit)
    check_digit = nums_a.pop
    # Process digits according to Luhn algorithm
    sum = computing_check_digit(nums_a)
    # Calculate what the check digit should be and compare with the actual check digit
    check_digit == (10 - (sum % 10)) % 10
  end

  # Process digits according to Luhn algorithm
  def computing_check_digit(nums_a)
    # Reverse the payload digits
    nums_a.reverse!
    # Double every second digit
    nums_a.each_with_index do |digit, i|
      next unless i.even?

      # Double the digit and subtract 9 if greater than 9
      doubled = digit * 2
      nums_a[i] = doubled > 9 ? doubled - 9 : doubled
    end
    # Sum all the resulting digits
    nums_a.sum
  end
end
