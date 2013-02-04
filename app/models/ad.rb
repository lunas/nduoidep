class Ad < ActiveRecord::Base
  attr_accessible :company_id, :page_id

  belongs_to :company
  belongs_to :page
end
