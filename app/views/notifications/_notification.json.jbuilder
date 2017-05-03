json.extract! notification, :id, :title, :content, :sender, :recipient, :link, :created_at, :updated_at
json.url notification_url(notification, format: :json)
