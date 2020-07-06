Sequel.migration do
  change do
    create_table :comments do
      primary_key :id
      Integer :parent_comment_id
      Integer :created_date
      foreign_key :post_id
      String :username
      String :title
      String :text
    end
  end
end
