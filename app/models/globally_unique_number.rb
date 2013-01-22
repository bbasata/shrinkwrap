class GloballyUniqueNumber < ActiveRecord::Base
  def self.next
    number = first || seed
    number.last_value = number.last_value + 1
    number.save
    number.last_value
  end

  def self.seed
    number = new.tap do |instance|
      instance.last_value = 1
    end
  end
end
