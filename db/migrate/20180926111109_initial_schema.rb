class InitialSchema < ActiveRecord::Migration[5.2]
  def change
    create_table "customers" do |t|
      t.string "first_name", default: "", null: false
      t.string "middle_initial", default: "", null: false
      t.string "last_name", default: "", null: false
      t.string "address1", default: "", null: false
      t.string "city", default: "", null: false
      t.string "state", default: "", null: false
      t.string "zip_code", default: "", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "items" do |t|
      t.string "name", default: "", null: false
      t.decimal "unit_price", precision: 8, scale: 2, default: "0.0", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "line_items" do |t|
      t.datetime "added_at", null: false
      t.decimal "price", precision: 8, scale: 2, default: "0.0", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "purchase_order_id"
      t.integer "item_id"
      t.decimal "quantity", precision: 8, scale: 2
      t.decimal "unit_price", precision: 8, scale: 2, default: "0.0"
    end

    create_table "purchase_orders" do |t|
      t.string "title"
      t.datetime "date"
      t.decimal "total", precision: 8, scale: 2, default: "0.0", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "customer_id"
    end
  end
end
