class CreateConfigs < ActiveRecord::Migration[6.0]
  def change
    create_table :configs do |t|
      t.float :app_commission
      t.float :sme_commission
      t.string :app_title

      t.timestamps
    end
  end
end
