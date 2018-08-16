Sequel.migration do
  change do
    create_table :posts do
      primary_key :id
      String :post, text: true
      String :title
      String :tags, text: true
      Integer :timestamp
    end
  end
end
