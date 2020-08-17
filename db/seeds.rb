User.destroy_all
Ingredient.destroy_all
Recipe.destroy_all
UserIngredient.destroy_all
UserRecipe.destroy_all
IngredientRecipe.destroy_all


#Users
val = User.create(username: "vnuccio", password: "1234", name: "Valerie Nuccio", location: "Budapest", logged_in: true)
adam = User.create(username: "asmo", password: "abcd", name: "Adam Smolenski", location: "Queens", logged_in: false)
anthony = User.create(username: "anthonyl", password: "kitten", name: "Anthony Nuccio", location: "Edinburgh", logged_in: false)

#Ingredients
garlic = Ingredient.create(name: "minced garlic")
tomatoes = Ingredient.create(name: "tomatoes")
spaghetti_noodles = Ingredient.create(name: "spaghetti noodle")
chocolate_chips = Ingredient.create(name: "chocolate chips")
flour = Ingredient.create(name: "flour")
cream = Ingredient.create(name: "cream")
sugar = Ingredient.create(name: "sugar")

#Recipe
spaghetti_recipe = Recipe.create(title: "Spaghetti", minutes_to_make: 25, servings: 4, directions: "boil the water. put sauce on it. mangia", photo_url: "", nutrition_facts: "Calories: 250, Total Fat: 10g, Carbohydrates: 25g, Protein: 4g", price: "4.25")
chocolate_cake = Recipe.create(title: "Chocolate Cake")


#ingredient_recipe
IngredientRecipe.create(ingredient_id: spaghetti_noodles.id, recipe_id: spaghetti_recipe.id)
IngredientRecipe.create(ingredient_id: garlic.id, recipe_id: spaghetti_recipe.id)
IngredientRecipe.create(ingredient_id: tomatoes.id, recipe_id: spaghetti_recipe.id)
IngredientRecipe.create(ingredient_id: chocolate_chips.id, recipe_id: chocolate_cake.id)
IngredientRecipe.create(ingredient_id: flour.id, recipe_id: chocolate_cake.id)
IngredientRecipe.create(ingredient_id: cream.id, recipe_id: chocolate_cake.id)
IngredientRecipe.create(ingredient_id: sugar.id, recipe_id: chocolate_cake.id)

#user_ingredients
UserIngredient.create(ingredient_id: garlic.id, user_id: adam.id)
UserIngredient.create(ingredient_id: chocolate_chips.id, user_id: val.id)

#user_recipes
UserRecipe.create(user_id: val.id, recipe_id: chocolate_cake.id, times_made: 2, review: "it was great!", star_rating: 5, last_time_made: Date.today)
UserRecipe.create(user_id: adam.id, recipe_id: spaghetti_recipe.id, times_made: 1, review: "it was dry", star_rating: 2, last_time_made: Date.today)





