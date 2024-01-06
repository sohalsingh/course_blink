# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

users = User.where(role: "admin", admin: true)

if users.empty?
    User.create(email: "admin@example.com", password: "password", password_confirmation:"password", admin: true, role: "admin")
end