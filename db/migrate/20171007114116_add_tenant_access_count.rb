class AddTenantAccessCount < ActiveRecord::Migration
  def change
    add_column :tenants, :access_count, :integer, default: 0
  end
end
