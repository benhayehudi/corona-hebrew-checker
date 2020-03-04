class DropWebsiteScreenshots < ActiveRecord::Migration[5.2]
  def change
    drop_table :website_screenshots
  end
end
