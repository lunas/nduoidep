class Page < ActiveRecord::Base
  attr_accessible :comment, :company_tokens, :image, :page_nr, :title
  attr_accessible :comment, :company_tokens, :image, :page_nr, :title, :issue_id, :as => :admin
  attr_reader :company_tokens

  belongs_to :issue
  has_many :ads
  has_many :companies, through: :ads

  mount_uploader :image, ImageUploader

  # Typus helper methods

  def company_tokens=(ids)
    self.company_ids = ids.split(",")
  end
  def company_tokens
    self.company_ids
  end

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
  def to_label
    "#{issue.title} - #{page_nr}"
  end
end
