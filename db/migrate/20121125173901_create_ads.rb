class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.integer :page_id
      t.integer :company_id

      t.timestamps
    end
  end
end
