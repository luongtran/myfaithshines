ActiveAdmin.register AssociateProducer do
  
  menu :parent => "Associate Producer",  :priority => 0,:parent_priority => 1 
  config.comments = false
  
  index do
    column :id
    column :name
    column :email
    column :site
    column :notes
    column :created_at
    column :updated_at      
    
    column :amount_owing,  :sortable => :amount_owing do |ap|    
        number_to_currency ap.amount_owing, :unit => "&#36;"      
    end 
    column :amount_paid,  :sortable => :amount_paid do |ap|    
        number_to_currency ap.amount_paid, :unit => "&#36;"      
    end
   
    
    default_actions
  end
  
end
