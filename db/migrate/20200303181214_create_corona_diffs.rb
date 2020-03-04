class CreateCoronaDiffs < ActiveRecord::Migration[5.2]
  def change
    create_table :corona_diffs do |t|

      t.timestamps
    end
  end
end
