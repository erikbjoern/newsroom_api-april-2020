class AddPublishedAtToArticle < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :published_at, :datetime
  end
end
