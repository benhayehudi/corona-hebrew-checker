class IncreaseDiffStorageSize < ActiveRecord::Migration[5.2]
  def change
    change_column :diff_storages, :website_data, :text, :limit => 500000
  end
end
