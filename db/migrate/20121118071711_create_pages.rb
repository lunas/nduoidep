class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.string :company
      t.string :image
      t.string :comment
      t.integer :page_nr

      t.timestamps
    end
  end
end
