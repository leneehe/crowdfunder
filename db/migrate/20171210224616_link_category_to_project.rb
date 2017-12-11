class LinkCategoryToProject < ActiveRecord::Migration[5.1]
  def change
    create_table :categories_projects, id: false do |t|
      t.belongs_to :category, index: true
      t.belongs_to :project, index:true
    end
  end
end
