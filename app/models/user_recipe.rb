# == Schema Information
#
# Table name: user_recipes
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  recipe_id      :integer
#  times_made     :integer
#  review         :string
#  star_rating    :integer
#  last_time_made :datetime
#
class UserRecipe < ActiveRecord::Base
    belongs_to :user
    belongs_to :recipe


    def self.save_and_rate(recipe)
        current_recipe_save = UserRecipe.find_or_create_by(user_id: CLI.current_user.id, recipe_id: recipe.spoonacular_id)
        if made?
            star_review=PROMPT.slider("Rating", max: 5, step: 1, symbols: {bullet: "✭"})
            written_review=PROMPT.ask("Tell us what you thought!")
            current_recipe_save.increment!(:times_made, by = 1)
            current_recipe_save.update(star_rating: star_review, review: written_review, last_time_made: Date.today)
        end
        CLI.welcome_nav_bar
    end
       
    def self.made?
        PROMPT.select("Did you make it just now?") do |menu|
            menu.choice "Made it!", true
            menu.choice "Just browsing", false
          end
    end

       
    def self.view_recipe_book
        if CLI.current_user.recipes.length == 0
            PROMPT.select("You don't seem to have any recipes saved! What would you like to do?") do |menu|
                menu.choice "Search for new recipes to add to my book!", -> {CLI.read_recipe(API.search)}
                menu.choice "Check out recipes others have saved", -> {self.community_recipes}
                menu.choice "Return to Main Menu", -> {CLI.welcome_nav_bar}
            end
        end
        recipe_array= CLI.current_user.recipes.map do |ele|
                # x=ele.print_recipe_book_entry
                {name: ele[:title], value: ele}
                end
        returned_ele = PROMPT.select("Which would you like to see?", recipe_array, per_page:10)
        self.print_recipe_book_entry(returned_ele)
     end

     def self.community_recipes
        returned_instances_array = UserRecipe.all.map(&:recipe).map do |ur_instance|
            {name: ur_instance[:title], value: ur_instance}
        end
        community_recipes = PROMPT.select("Which would you like to see?", returned_instances_array, per_page:10)
        new_json = API.read_recipe(community_recipes.spoonacular_id)
        CLI.read_recipe(new_json)
    
     end


    def self.print_recipe_book_entry(ele)
        
        system ("clear")
        # Image.new(ele.photo_url)
        CLI.centered(ele.title, true)
        puts ele.summary.green
        puts
        
        a1 = "Ready in " + "#{ele.minutes_to_make}".red 
        b1 = "Servings " + "#{ele.servings}".red
        c1 = "Price per Serving " + "#{ele.price}".red
        first_column = a1+ "\n" + b1 + "\n" + c1
        puts
        a2 = ele.nutrition_facts
        puts
        ingredient_explanation = ("-             Ingredient List: (" + "WHITE".white + " means we have it " + "LIGHT BLUE".light_cyan + " means you have grocery shopping to do)")
        CLI.centered(ingredient_explanation)

        
        needs = []
        all_ingredients = []
            
        ele.info_json["extendedIngredients"].each do |ingredient| 
            
            if UserIngredient.find_by(user_id: CLI.current_user.id, ingredient_id: ingredient["id"])
                all_ingredients << ingredient["originalString"].white
            else
                all_ingredients << ingredient["originalString"].light_cyan
                needs << ingredient["name"]
            end
        end
        table = TTY::Table.new ['Info'.bold.magenta,'Nutrition Facts'.bold.magenta, 'Ingredients'.bold.magenta], [[first_column, a2, all_ingredients.join("\n")]]
        
        CLI.centered(table.render(:ascii, multiline: true))
        puts 
        begin
            directions =ele.info_json['analyzedInstructions'][0]['steps']
        rescue
            directions = [{'number'=> 1, 'step'=> "NO INSTRUCTIONS PROVIDED"}]
        end

        directions.each do |step|
            puts "Step #{step['number']}.".blue
            puts "     #{step['step']}".yellow
            
        end
        puts 
        puts "You need to go buy: " + needs.join(", ").light_cyan.bold + "."
        puts
        found_rating = UserRecipe.find_by(recipe_id: ele.id, user_id: CLI.current_user.id)
        self.return_rating(found_rating.id)
        self.update_made_and_review(found_rating.id)
        
        sleep(0.5)
        puts
    

        PROMPT.select("What would you like to do now?") do |menu|
            menu.choice "See my Saved Recipes again", -> {view_recipe_book}
            menu.choice "Return to Main Menu", -> {CLI.welcome_nav_bar}
            menu.choice "Exit", -> {CLI.exit_and_kill_music}
        end
       
    end

    def self.return_rating(id)
       user_recipe_instance= UserRecipe.find(id)
       user_recipe_instance
       puts "You've made this".cyan
       puts "#{user_recipe_instance.times_made} times".white
       puts "The last time you made this was".cyan
       puts  user_recipe_instance.last_time_made.strftime("%B, %d, %Y").white
       puts "You previously rated this recipe as".cyan
       puts  "#{user_recipe_instance.star_rating} stars".white
       puts "and said:".cyan
       puts "#{user_recipe_instance.review}".white
    end
    
    
    def self.update_made_and_review(id)
        user_recipe_instance= UserRecipe.find(id)
        if made?
            user_recipe_instance.last_time_made=Date.today
            user_recipe_instance.increment!(:times_made, by = 1)     
        end
        
        if update_review?
            star_review=PROMPT.slider("Rating", max: 5, step: 1, symbols: {bullet: "✭"})
            written_review=PROMPT.ask("Tell us what you thought!")
            user_recipe_instance.update(star_rating: star_review, review: written_review)
        end
    end


    def self.update_review?
        PROMPT.select("Wanna change your rating?") do |menu|
            menu.choice "Yeah, I've changed my mind", true
            menu.choice "Nope! It's just as I remember it", false
          end
    end


end