class Page < ActiveRecord::Base
  attr_accessible :comment, :company, :image, :page_nr, :title
  attr_accessible :comment, :company, :image, :page_nr, :title, :as => :admin

  belongs_to :issue

  # Typus methods

  def self.issues
    joins(:issue).select('issues.title').uniq.map(&:title)
  end
  def self.page_nrs
    pluck(:page_nr)
  end
end
