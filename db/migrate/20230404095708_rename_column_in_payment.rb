class RenameColumnInPayment < ActiveRecord::Migration[7.0]
  def change
    rename_column :payments, :method, :pay_method
  end
end
