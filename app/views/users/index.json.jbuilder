json.users do |json|
  json.array!(@users) do |user|
    json.extract! user, :id, :email, :created_at, :updated_at
  end
end
