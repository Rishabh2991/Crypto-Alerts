class CreateAlertsTables < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      CREATE TYPE alert_status AS ENUM('deleted', 'active');
    SQL

    create_table :alerts do |t|
      t.references :user,index: true,foreign_key: true, null: false
      t.integer :target_price
      t.column :status, :alert_status, default: 'active'
      t.integer :trigger_count_history

      t.timestamps

    end
  end

  def down
    drop_table :alerts_tables
    drop_type :alert_status
  end
end