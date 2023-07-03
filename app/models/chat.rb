class Chat < ApplicationRecord
  has_and_belongs_to_many :users
  has_many :messages, dependent: :destroy

  validate :users_are_distinct_and_there_are_two_of_them

  def users_are_distinct_and_there_are_two_of_them
    set = Set.new
    valid = users.map { |u| u.id }.none? { |u| !set.add? u } && set.count == 2
    errors.add(:users, message: "must have at least two unique ones") unless valid
  end
end
