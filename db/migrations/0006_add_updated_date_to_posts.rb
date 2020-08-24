Sequel.migration do
  change do
    alter_table :posts do
      add_column :updated_at, Integer
    end
  end
end
