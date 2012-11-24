class Page < ActiveRecord::Base
  attr_accessible :comment, :company, :image, :page_nr, :title
  attr_accessible :comment, :company, :image, :page_nr, :title, :issue_id, :as => :admin

  belongs_to :issue

  mount_uploader :image, ImageUploader


  # Typus helper methods

  def self.issues
    joins(:issue).select('issues.title').uniq.map(&:title)
  end
  def self.page_nrs
    pluck(:page_nr)
  end
  def image_preview
    if self.image?
      "<img src=\"#{self.image}\" width=\"100\" />".html_safe
    end
  end
end
