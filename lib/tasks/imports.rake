require 'rest-client'

namespace :imports do
  desc 'Importações de usuários do sistema Odin'
  task users: :environment do
    users = JSON.parse(RestClient.get('http://odin.defensoria.to.gov.br/usuarios.json'))

    users.each do |user|
      new_user = User.new(attributes_user(user))
      if new_user.save(validate: false)
        puts "Servidor #{new_user['username']} salvo com sucesso."
      else
        puts "Servidor #{new_user['username']} não foi salvo com sucesso.  !!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      end
    end
  end

  desc 'Importações de Notifcações do Sistema Odin'
  task notifications: :environment do
    notifications = JSON.parse(RestClient.get('http://odin.defensoria.to.gov.br/notificacoes.json'))

    notifications.each do |notification|
      new_notification = Notification.new(attributes_notification(notification))
      if new_notification.save(validate: false)
        puts "Notificação #{new_notification['id']} salva com sucesso."
        next if notification['notificacoes_individuais'].blank?
        notification['notificacoes_individuais'].each do |individual|
          individual_notification = IndividualNotification.new(attributes_individual(individual, new_notification.id))
          if individual_notification.save(validade: false)
            puts "------------------- Notificação #{new_notification.id},  Individual #{individual_notification.id}"
          else
            puts "******************* Notificação #{notification.id}, Individual #{individual.id}"
          end
        end
      else
        puts "Notificação #{notification['id']} não foi salva com sucesso.  !!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      end
    end
  end

  desc 'Importação dos nomes dos usuários do sistema'
  task names: :environment do
    servidores = JSON.parse(RestClient.get('http://odin.defensoria.to.gov.br/servidores.json'))

    servidores.each do |servidor|
      user = find_user(servidor['cpf'])
      if user.nil?
        puts "Usário não encontrado #{servidor['nome']} - #{servidor['cpf']}"
      else
        user.name = servidor['to_s']
        user.save!
      end
    end
  end

  task all: :environment do
    Rake::Task['imports:users'].invoke
    Rake::Task['imports:notifications'].invoke
    Rake::Task['imports:names'].invoke
  end
end

def attributes_user(user)
  user.slice('email', 'encrypted_password', 'cpf', 'username')
      .merge('name' => user['nome'])
      .symbolize_keys
end

def attributes_notification(n)
  user = find_sender(n['remetente_old_cpf'], n['remetente_cpf'])
  { app: n['aplicacao'], title: n['título'], link: n['link'], sender: user }
end

def attributes_individual(individual, notification_id)
  user = find_user(individual['cpf'])
  { notification_id: notification_id, user: user, read_at: individual['read_at'] }
end

def find_sender(sender_old, sender_new)
  cpf = sender_old ? sender_old : sender_new
  find_user(cpf)
end

def find_user(cpf)
  User.find_by(cpf: cpf)
end
