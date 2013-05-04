
#usage rake save_snapshot['http://localhost:3000/save_snapshot/']

#usage heroku run rake save_snapshot['http://good-dog.herokuapp.com/save_snapshot/']
task :save_snapshot, [:url]  => :environment do  |t, args|
  include RestClient
  
  puts "Updating non profits"
  #updateable_nonprofits = NonProfit.all(:conditions=> ["update_flag = ?", true])
  updateable_nonprofits = NonProfit.all
  puts "Number of non profits: " + updateable_nonprofits.length.to_s
  updateable_nonprofits.each do |non_profit|
    RestClient.get(args.url + non_profit.id.to_s)
    non_profit.update_flag = false;
    non_profit.save
  end
   
   
end