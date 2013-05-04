class ProfitSponsor < ActiveRecord::Base
  
  belongs_to :sponsor
  belongs_to :non_profit
  
end
