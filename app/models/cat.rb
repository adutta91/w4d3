require 'action_view'

class Cat < ActiveRecord::Base
  include ActionView::Helpers::DateHelper

  CAT_COLORS = %w(black white orange brown)

  has_many(
    :rental_requests,
    class_name: "CatRentalRequest",
    dependent: :destroy
  )

  validates(
    :birth_date,
    :color,
    :name,
    :sex,
    presence: true
  )

  validates :color, inclusion: CAT_COLORS
  validates :sex, inclusion: %w(M F)
  validate :user_exists?

  def user_exists?
    return if self[:user_id].nil?
    user = User.find_by(id: self[:user_id])
    self.errors[:user_id] << "no user" if user.nil?
  end

  def age
    time_ago_in_words(birth_date)
  end

  belongs_to :owner, :class_name => "User", :foreign_key => "user_id"
end
