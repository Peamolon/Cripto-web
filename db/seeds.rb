# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

currencies = {
  "Bitcoin" => "BTC",
  "Ethereum" => "ETH",
  "Cardano" => "ADA"
}

returns = [0.05, 0.042, 0.01]

currencies.each_with_index do |(name, symbol), index|
  Crypto.create!(name: name, symbol: symbol, monthly_return: returns[index] * 100)
end