ActiveAdmin.register SoldBlock do
    
    menu :parent => "Associate Producer", :priority => 0, :parent_priority => 1

  index do
    column :id
    column :associate_producer
    column :amount,  :sortable => :amount do |ap|    
        number_to_currency ap.amount, :unit => "&#36;"      
    end
    column :compensation_due,  :sortable => :compensation_due do |ap|    
        number_to_currency ap.compensation_due, :unit => "&#36;"      
    end
     column :created_at
     column :updated_at
     
    default_actions
  end
  
  
end
