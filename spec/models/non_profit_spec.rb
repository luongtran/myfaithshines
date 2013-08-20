require 'spec_helper'

describe NonProfit do
  
  NonProfit.create({:name => "test", :state_id => 1, })
  @non_profits = NonProfit.search_near_by_zipcode('12288', 25)
  expect(@non_profits).to be_nil
end
