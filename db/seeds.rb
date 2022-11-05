User.create!(
  name: "sample_name",
  email: "sample@mail.com",
  password: "password",
  admin: "true"
            )

5.times do |i| 
  Label.create!(
  name: "sample#{i+1}"
  )
end