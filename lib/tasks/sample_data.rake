namespace :db  do
	desc "fill database with fake users"
	task populate: :environment do
		User.create!(name: "example user", email: "example_user@rails.org", 
			password: "foobar", password_confirmation: "foobar")

		99.times do |n|
			name = Faker::Name.name
			email = "example_user#{n+1}@rails.org"
			password = "password"
			User.create!(name: name, email: email, password: password, 
				password_confirmation: password)
		end

		users = User.all(limit: 6)

		50.times do |n|
			content = Faker::Lorem.sentence(5)
			users.each { |user| user.posts.create!(title: "Post no #{ n }" , text: content) }
		end

	end
	
end