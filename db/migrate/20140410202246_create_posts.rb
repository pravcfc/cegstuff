class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :text
      t.user_id :integer
      t.timestamps
    end
 	
  end
end
