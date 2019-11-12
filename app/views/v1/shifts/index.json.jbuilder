json.array! @shifts do |shift|
  json.partial! 'v1/shifts/shift', shift: shift
end
