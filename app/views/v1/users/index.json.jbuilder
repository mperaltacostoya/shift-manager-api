json.array! @users do |user|
  json.partial! 'v1/users/user', user: user
end
