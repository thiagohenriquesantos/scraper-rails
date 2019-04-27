class CreateCadastros < ActiveRecord::Migration[5.2]
  def change
    create_table :cadastros do |t|
      t.string :nome
      t.string :url_twitter

      t.timestamps
    end
  end
end
