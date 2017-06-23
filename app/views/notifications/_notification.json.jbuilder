json.extract! notification, :id, :title, :content, :sender, :link, :created_at,
              :updated_at, :channel, :module, :users
json.url notification_url(notification, format: :json)
