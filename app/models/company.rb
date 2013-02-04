class Company < ActiveRecord::Base
  attr_accessible :name
  attr_accessible :name, as: :admin

  has_many :ads
  has_many :pages, through: :ads

  # typus helpers

  def to_label
    name
  end
end
