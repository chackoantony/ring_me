class CreateCalls < ActiveRecord::Migration[7.1]
  def change
    create_table :calls do |t|
      t.string :to_number, null: false
      t.text :body, limit: 2000
      t.integer :status, index: true, null: false, default: 0
      t.string :twilio_status, index: true, null: true
      t.string :sid, index: { unique: true, where: "sid IS NOT NULL" }

      t.timestamps
    end
  end
end
