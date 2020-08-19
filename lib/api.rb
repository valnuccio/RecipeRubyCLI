class API

    def self.api_call(url)        
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Get.new(url)
        request["x-rapidapi-host"] = HOST
        request["x-rapidapi-key"] = KEY

        response = http.request(request)
        JSON.parse(response.read_body)
    end

    def self.search
        recipe = PROMPT.ask("What would you like to search for? >> ")
        url = URI("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/search?query=#{recipe}")

        found_recipes = api_call(url)
        choices = found_recipes["results"].map {|choice| 
        {">>> #{choice['title'].red}  Ready: in #{choice['readyInMinutes']}": choice["id"] }}

        get_recipe_id = PROMPT.select("What looks good?", choices, per_page:10)
        self.read_recipe(get_recipe_id)
    end

    def self.search_ingredient
        ingredient = PROMPT.ask("Enter Ingredient(s) Do You Wish to Include >> ")
        url = URI("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/findByIngredients?ingredients=#{ingredient}")
        found_recipes = api_call(url)
        choices = found_recipes.map {|choice| 
        {">>> #{choice['title'].red}": choice["id"] }}
        get_recipe_id = PROMPT.select("What looks good? Displaying Top 5 Recipes w/ #{ingredient}", choices, per_page:5)
        # self.read_recipe(get_recipe_id)
        self.read_recipe(get_recipe_id)
    end

    def self.read_recipe(recipe_id)  # GET RECIPE INFO
        system "clear"
        url = URI("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/#{recipe_id}/information")
        self.api_call(url)
    end


    def self.get_recipe_price(recipe_id)
        url = URI("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/#{recipe_id}/priceBreakdownWidget.json")
        cost_info = self.api_call(url)
        (cost_info["totalCostPerServing"]*(0.01)).round(2)
    end

    def self.get_recipe_nutrition_facts(recipe_id)
        url = URI("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/#{recipe_id}/nutritionWidget.json")
        facts = self.api_call(url)
        calories = facts["calories"]
        carbs = facts["carbs"]
        fat = facts["fat"]
        protein = facts["protein"]
        all_info="\n    Calories: #{calories} \n    Carbs: #{carbs} \n    Fat: #{fat} \n     Protein: #{protein}"
    end

    def self.joke
        url = URI("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/food/jokes/random")
        self.api_call(url)["text"]
    end

    def self.random_recipe
        url = URI("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/random?number=1")
        food_outer_hash = self.api_call(url)
        food_outer_hash["recipes"][0]
    end

    def self.fact
        url = URI("https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/food/trivia/random")
        self.api_call(url)["text"]
    end

end
