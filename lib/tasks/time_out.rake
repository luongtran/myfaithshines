

task :time_out, [:url]  => :environment do  |t, args|
  include RestClient
 
  reservation_list = Reservation.all

  puts "Number of reservations: " + reservation_list.length.to_s
  
  reservation_list.each do |reserv|
    time_left = (reserv.created_at + 20.minutes) - Time.now
    last_reserv = Reservation.find_last_by_user_id(reserv.user_id)
    
    if time_left <= 0          
       if (last_reserv.created_at + 20.minutes) - Time.now > 0       
         break
       else
          Reservation.destroy_all(["id = ?", reserv.id])  
       end   
    end

  end
   
   
end