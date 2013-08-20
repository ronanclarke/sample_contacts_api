class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.string :note
      t.datetime :start_time
      t.integer :duration

      t.timestamps
    end
  end
end
