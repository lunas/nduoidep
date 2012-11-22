class Page < ActiveRecord::Base
  attr_accessible :comment, :company, :image, :page_nr, :title
  attr_accessible :comment, :company, :image, :page_nr, :title, :as => :admin

  belongs_to :issue

  mount_uploader :image, ImageUploader


  # Typus helper methods

  def self.issues
    joins(:issue).select('issues.title').uniq.map(&:title)
  end
  def self.page_nrs
    pluck(:page_nr)
  end
end
