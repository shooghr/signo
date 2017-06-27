namespace :notificacao do  
  desc 'Criando ligação entre usuario e notificação'
  task usuario: :environment do
    n = Notification.all
    u = User.first

    n.each do | ns |
      ni = IndividualNotification.new
      ni.notification_id = ns.id
      ni.user_id = u.id 
      ni.save!
    end
  end
end
