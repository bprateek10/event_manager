class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.boolean :allday, default: false
      t.boolean :completed, default: false
      t.datetime :starttime
      t.datetime :endtime

      t.timestamps
    end
  end
end
