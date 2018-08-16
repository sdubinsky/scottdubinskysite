Sequel.migration do
  change do
    create_table :views do
      primary_key :id
      foreign_key :post_id
      Integer :timestamp
      String :viewer_ip
    end
  end
end
