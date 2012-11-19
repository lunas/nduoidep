class Issue < ActiveRecord::Base
  attr_accessible :date, :title
  attr_accessible :date, :title, as: :admin

  has_many :pages, :dependent => :destroy

end
