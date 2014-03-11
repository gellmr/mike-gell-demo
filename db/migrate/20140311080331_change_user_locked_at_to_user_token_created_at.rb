class ChangeUserLockedAtToUserTokenCreatedAt < ActiveRecord::Migration
  def change
    rename_column :users, :locked_at, :token_created_at
  end
end
