ActiveAdmin.register PaymentProducer do
   
    menu :parent => "Associate Producer",  :priority => 0,:parent_priority => 1
    
    
    
    index do
      column :id
      column :date      
      column :associate_producer
      column :amount
      column :created_at
      column :updated_at
      
      default_actions
    end
end
