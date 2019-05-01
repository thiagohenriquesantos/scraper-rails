class TwitterFields < ActiveRecord::Migration[5.2]
  def change
    add_column :cadastros, :twitter_title, :string
    add_column :cadastros, :twitter_description, :text
    add_column :cadastros, :twitter_user, :string
    add_column :cadastros, :short_url, :string
  end
end
