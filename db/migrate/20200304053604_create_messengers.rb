class CreateMessengers < ActiveRecord::Migration[5.2]
  def change
    create_table :messengers do |t|

      t.timestamps
    end
  end
end
