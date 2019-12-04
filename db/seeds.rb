require 'faker'

puts "Creating Users"
10.times do
    User.create(name: Faker::Name.name)
end
puts "Users added"

puts "Creating Recipes"
10.times do
    Recipe.create(name: Faker::Food.dish, description: Faker::Food.description, creator_id: User.all.sample.id)
end
puts "Recipes added"

puts "Creating Ingredients"
50.times do
    Ingredient.create(name: Faker::Food.ingredient)
end
puts "Ingredients added"

puts "Creating Categories"
Category.create(title: 'Seafood')
Category.create(title: 'Indian Food')
Category.create(title: 'Fast Food')
Category.create(title: 'Chineses Food')
Category.create(title: 'Italian Food')
Category.create(title: 'Vegetarian')
Category.create(title: 'Vegan')
puts "Categories Created"

puts "Joining Recipes and Ingredients"
20.times do
    RecipeIngredient.create(recipe_id: Recipe.all.sample.id, ingredient_id: Ingredient.all.sample.id, amount: Faker::Food.measurement)
end
puts "Recipes and Ingredients joined"

puts "Joining Recipes and Users via Meal"
50.times do
    Meal.create(user_id: User.all.sample.id, recipe_id: Recipe.all.sample.id, rating: rand(5))
end
puts "Meals created"

puts "Joining User categories"
7.times do
    UserCategory.create(category_id: Category.all.sample.id, user_id: User.all.sample.id)
end
puts "User Categories joined."

puts "Joining Recipe Categories"
10.times do
    RecipeCategory.create(category_id: Category.all.sample.id, recipe_id: Recipe.all.sample.id)
end
puts "Recipe Categories joined."
