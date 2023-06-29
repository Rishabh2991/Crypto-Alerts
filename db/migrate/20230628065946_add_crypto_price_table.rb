class AddCryptoPriceTable < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      CREATE TYPE coin_types AS ENUM('btc', 'dogo');
    SQL

    create_table :crypto_prices do |t|
      t.column :coin, :coin_types, default: 'btc'
      t.integer :current_price
      t.json :payload

      t.timestamps

    end
  end

  def down
    drop_table :crypto_prices
    execute <<-SQL
      DROP TYPE coin_types;
    SQL
  end
end
