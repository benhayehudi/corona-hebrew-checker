class CreateWebsiteScreenshot < ActiveRecord::Migration[5.2]
  def change
    create_table :website_screenshots do |t|
      t.binary :screenshot

      t.timestamps
    end
  end
end
