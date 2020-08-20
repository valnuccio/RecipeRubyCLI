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
        PROMPT.select("Did you make it?") do |menu|
            menu.choice "Made it!", true
            menu.choice "Just browsing", false
          end
    end

       
    def self.view_recipe_book
        recipe_array= CLI.current_user.recipes.map do |ele|
                # x=ele.print_recipe_book_entry
                {name: ele[:title], value: ele}
                end
        returned_ele = PROMPT.select("Choose your destiny?", recipe_array, per_page:10)
        self.print_recipe_book_entry(returned_ele)
     end


    def self.print_recipe_book_entry(ele)
        system "clear"
    # Image.new(ele.photo_url)
    puts ele.title.red  #ASCII HERE
    puts ele.summary.green
    puts
    puts "Ready in " + "#{ele.minutes_to_make}".red
    puts "Servings " + "#{ele.servings}".red
    puts "Price per Serving " + "#{ele.price}".red
    puts
    puts "Nutrition Facts: #{ele.nutrition_facts.red}"
    puts



    extended_ing_array=ele.info_json["extendedIngredients"]

    extended_ing_array.each do |ele| 
        puts ele["originalString"].light_cyan
    end
    
   puts 

    ele.info_json['analyzedInstructions'][0]['steps'].each do |step|
        puts "Step #{step['number']}.".blue
        puts "     #{step['step']}".yellow
        
    end
    puts
    puts
    puts
    puts
    self.return_rating(ele.id)

    sleep(3)
    puts
    puts
    puts 

    CLI.welcome_nav_bar

       
    end

    def self.return_rating(id)
       user_recipe_value=self.all.select do |saved_recipe|
            saved_recipe.recipe_id == id
            end
            user_recipe_value
            puts "You've made this #{user_recipe_value[0].times_made} times".cyan
            puts "The last time you made this was #{user_recipe_value[0].last_time_made}".cyan
            puts "You previously rated this recipe as".cyan
            puts  "#{user_recipe_value[0].star_rating} stars".white
            puts "and said:".cyan
            puts "#{user_recipe_value[0].review}".white
        end
    
end