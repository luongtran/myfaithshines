class ChangeDataTypeForCompensationDue < ActiveRecord::Migration
  def up
     change_table :sold_blocks do |t|
      t.change :compensation_due, :float
    end
  end

  def down
    change_table :soldblock do |t|
      t.change :compensation_due, :integer
    end
  end
end
