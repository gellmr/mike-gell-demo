class AddUserLockedAndPasswordResetToken < ActiveRecord::Migration
  def change
    add_column :users, :account_locked, :boolean
    add_column :users, :locked_at, :datetime
    add_column :users, :password_reset_token, :string
  end
end
