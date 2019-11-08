json.id shift.id
json.userId shift.user_id
json.comments shift.comments
json.isOpen shift.open
json.details shift.entries do |entry|
  json.type entry.entry_type == 'check_in' ? 'checkIn' : 'checkOut'
  json.time entry.entry_datetime
  json.comments entry.comments
end