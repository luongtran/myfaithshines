class AddLogoToNonProfit < ActiveRecord::Migration
  def change
    add_column :non_profits, :logo_file_name, :string

    add_column :non_profits, :logo_content_type, :string

    add_column :non_profits, :logo_file_size, :integer

  end
end
