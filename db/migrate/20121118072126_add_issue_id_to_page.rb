class AddIssueIdToPage < ActiveRecord::Migration
  def change
    add_column :pages, :issue_id, :integer
  end
end
