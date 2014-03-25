class AddCountry < ActiveRecord::Migration
  def up
    add_column :contacts, :phone_country_code, :string

  end

  def down
    remove_column :contacts, :phone_country_code
  end
end
