class CreateSpinaProjectsTable < ActiveRecord::Migration
  def change
    create_table :spina_projects do |t|
      t.string :title
      t.string :slug
      t.text :description
      t.string :duration
      t.integer :project_category_id
      t.timestamps
    end
  end
end
