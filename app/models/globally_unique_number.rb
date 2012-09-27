class GloballyUniqueNumber < ActiveRecord::Base
  def self.next
  	number = first
  	number.last_value = number.last_value + 1
  	number.save
  	number.last_value
  end

  def self.seed
    number = new
    number.last_value = 1
    number.save
  end
end
