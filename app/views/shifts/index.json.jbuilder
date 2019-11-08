json.array! @shifts do |shift|
  json.partial! 'shifts/shift', shift: shift
end