class AddCompanyIdToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :company_id, :bigint
  end
end
