# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
10.times do
	@uid = []
	@user = User.new
	@user.name = Faker::FunnyName.name
	@user.password = '123'
	@user.save
	@uid << @user.id

	@list = List.new
	@list.title = Faker::Nation.capital_city
	@list.content = Faker::Lorem.paragraph
	@list.user_id = @uid.sample
	@list.save
end	