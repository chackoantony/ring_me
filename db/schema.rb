# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_07_21_072950) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "calls", force: :cascade do |t|
    t.string "to_number", null: false
    t.text "body"
    t.integer "status", default: 0, null: false
    t.string "twilio_status"
    t.string "sid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sid"], name: "index_calls_on_sid", unique: true, where: "(sid IS NOT NULL)"
    t.index ["status"], name: "index_calls_on_status"
    t.index ["twilio_status"], name: "index_calls_on_twilio_status"
  end

end
