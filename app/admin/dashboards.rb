ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    section "Non Profits" do
     ul do
       li link_to("New Non Profit", new_admin_non_profit_path)
      end
    end
    section "Sponsors" do
     ul do
       li link_to("New Sponsor", new_admin_sponsor_path)
      end
    end


  end # content
end
