class CreateUsers < ActiveRecord::Migration
  def change
    create_table(:users, id: false) do |t|
      t.string :username

      t.timestamps
    end

    execute "ALTER TABLE users ADD PRIMARY KEY(username);"
  end
end
