Sequel.migration do
  change do
    alter_table :posts do
      add_unique_constraint :title
    end
  end
end
