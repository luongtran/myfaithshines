class IdStartToCarts < ActiveRecord::Migration
  def up
    execute("ALTER SEQUENCE carts_id_seq RESTART 10000;")    
  end

  def down
  end
end
