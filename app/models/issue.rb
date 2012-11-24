class Issue < ActiveRecord::Base
  attr_accessible :date, :title
  attr_accessible :date, :title, as: :admin

  has_many :pages, :dependent => :destroy

  # Typus helper methods:

  def to_label
    "#{title} (#{date.strftime("%B")} #{date.year})"
  end
end
