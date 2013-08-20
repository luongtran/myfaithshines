class IdStartToCarts < ActiveRecord::Migration
  def up
    execute("ALTER TABLE carts AUTO_INCREMENT=10000;")    
  end

  def down
  end
end
