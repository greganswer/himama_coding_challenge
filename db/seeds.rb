# Users
users = User.create!([
  {
    first_name: "Greg", 
    last_name: "Answer", 
    email: "greganswer@gmail.com", 
    password: 'secret'
  },
  {
    first_name: "Jane", 
    last_name: "Doe", 
    email: "jane@example.com", 
    password: 'secret'
  },
])

# ClockEvents
users.each do |user|
  ClockEvent.create!(user: user, clock_in_at: 2.hours.ago, clock_out_at: Time.current)
end
