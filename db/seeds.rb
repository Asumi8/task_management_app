10.times do |i|
  User.create!(
    name: "sample_name#{i+1}",
    email: "sample#{i+1}@mail.com",
    password: "password",
    admin: "false"
  )
end

User.create!(
  name: "admin_name",
  email: "admin@mail.com",
  password: "password",
  admin: "true"
  )


10.times do |i| 
  Label.create!(
    name: "sample#{i+1}"
  )
end

10.times do |i|
  Task.create!(
    title: "sample_title#{i+1}",
    content: "sample_content#{i+1}",
    expired_at: "2022-11-06",
    status: "未着手",
    priority: "高",
    user_id: 23,
  )
end