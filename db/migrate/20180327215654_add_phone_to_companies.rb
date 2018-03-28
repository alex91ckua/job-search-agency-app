class AddPhoneToCompanies < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :phone, :string
  end
end
