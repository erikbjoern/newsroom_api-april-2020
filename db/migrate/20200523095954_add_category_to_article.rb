class AddCategoryToArticle < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :category, :integer, default: 0
  end
end
