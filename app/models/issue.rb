class Issue < ActiveRecord::Base
  attr_accessible :date, :title
  attr_accessible :date, :title, as: :admin

  has_many :pages, dependent: :destroy, order: "page_nr ASC"

  scope :latest, order("date DESC").limit(1)

  def self.all_issues_with_id
    order("date DESC").map { |issue| [issue.title + ' -- ' + issue.date.to_s, issue.id, ] }
  end

  def first_pages
    pages.order("page_nr ASC").limit(5)
  end

  # Return array of
  def companies
    #sql = "select distinct c.name
    #       from (issues as i inner join pages as p on i.id=p.issue_id)
    #       inner join ads as a on p.id=a.page_id
    #       inner join companies as c on a.company_id=c.id
    #       where i.id = #{id};"
    Issue.select("companies.id, companies.name")
         .joins(pages: {ads: :company})
         .where("issues.id=#{id}")
         .order("companies.name ASC")
         .uniq
         .map{|c| [c.name, c.id] }
  end


  # Typus helper methods:

  def to_label
    "#{title} (#{date.strftime("%B")} #{date.year})"
  end
end
