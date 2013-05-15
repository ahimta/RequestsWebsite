class CreateLeaves < ActiveRecord::Migration
  def change
    create_table :leaves do |t|
      t.string :applicant
      t.string :reason
      t.boolean :accepted
      t.integer :user_id

      t.timestamps
    end
  end
end
