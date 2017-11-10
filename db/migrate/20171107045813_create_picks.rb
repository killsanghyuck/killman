class CreatePicks < ActiveRecord::Migration[5.0]
  def change
    create_table :picks do |t|
      t.datetime :enter_time
      t.datetime :exit_time
      t.integer :pick_state
      t.boolean :coincide
      t.integer :reservation_id, limit: 8
      t.integer :payment_code
      t.integer :time_code
      t.datetime :cancel_time
      t.boolean :test
      t.string :car_number
      t.datetime :complete_time
      t.text :rate_table
      t.text :rate_tickets
      t.integer :free_time
      t.text :gear_price
      t.string :cancel_reason
      t.datetime :arrive_time
      t.timestamps
    end
  end
end
