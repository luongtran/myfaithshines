class RemoveMonthAndLink < ActiveRecord::Migration
  def up

    remove_column  :dogs, :link

  end

  def down
  end
end
