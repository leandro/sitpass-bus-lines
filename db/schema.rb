# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100614043448) do

  create_table "bus_line_places", :force => true do |t|
    t.string   "bairro"
    t.string   "logradouro"
    t.integer  "order"
    t.integer  "bus_line_id"
    t.boolean  "ida",             :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "bairro_slug"
    t.string   "logradouro_slug"
  end

  add_index "bus_line_places", ["bairro_slug"], :name => "index_bus_line_places_on_bairro_slug"
  add_index "bus_line_places", ["logradouro_slug"], :name => "index_bus_line_places_on_logradouro_slug"

  create_table "bus_lines", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
