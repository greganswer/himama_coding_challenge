class CreateClockEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :clock_events do |t|
      t.belongs_to :user, null: false, index: true
      t.datetime :clock_in_at
      t.datetime :clock_out_at

      t.timestamps
    end
  end
end
