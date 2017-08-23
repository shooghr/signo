namespace :notificacao do
  desc 'Criando ligação entre usuario e notificação'
  task usuario: :environment do
    n = Notification.all
    u = User.first

    n.each do |ns|
      ni = IndividualNotification.new
      ni.notification_id = ns.id
      ni.user_id = u.id
      ni.save!
    end
  end

  desc 'criando usuario padrão'
  task make_users: :environment do
    User.create(email: 'luiz.aa@defensoria.to.gov.br', cpf: '02052283307', username: 'luiz.aa',
                password: '123456', password_confirmation: '123456')
    User.create(email: 'lucivaldo.cc@defensoria.to.gov.br', cpf: '01435061101', username: 'lucivaldo.cc',
                password: '123456', password_confirmation: '123456')
    User.create(email: 'ricardo.ss@defensoria.to.gov.br', cpf: '35308899894', username: 'ricardo.ss',
                password: '123456', password_confirmation: '123456')
    User.create(email: 'ricardo.tj@defensoria.to.gov.br', cpf: '00011122233304', username: 'ricardo.ss',
                password: '123456', password_confirmation: '123456')
  end
end
