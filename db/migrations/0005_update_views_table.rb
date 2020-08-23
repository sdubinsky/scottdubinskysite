Sequel.migration do
  up do
    alter_table :views do
      drop_column :post_id
      add_column :endpoint, String
      add_column :country_code, String
    end
  end

  down do
    alter_table :views do
      drop_column :endpoint
      drop_column :country_code
      add_column :post_id, Integer
    end
  end
end
