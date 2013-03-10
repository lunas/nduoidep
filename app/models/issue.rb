class Issue < ActiveRecord::Base
  attr_accessible :date, :title
  attr_accessible :date, :title, as: :admin

  has_many :pages, dependent: :destroy, order: "page_nr ASC"

  scope :latest, order("date DESC").limit(1)

  def first_pages
    pages.order("page_nr ASC").limit(5)
  end

  # Typus helper methods:

  def to_label
    "#{title} (#{date.strftime("%B")} #{date.year})"
  end
end
