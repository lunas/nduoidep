class Ad < ActiveRecord::Base
  attr_accessible :company_id, :page_id
  attr_protected :company_id, :page_id, as: :admin

  belongs_to :company
  belongs_to :page
  belongs_to :issue

  def to_label
    "#{company.name}, Issue #{page.issue.title}, page #{page.page_nr}"
  end

end
