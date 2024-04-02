class AddOrganisationIdToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :organisation_id, :integer
  end
end
