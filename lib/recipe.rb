# This class is responsible for working with recipe
class Recipe
  attr_reader :nutrition, :servings, :ingredients,
              :feedback

  # Ingredient struct contains information about the ingredient
  Ingredient = Struct.new :name, :amount, :unit
  # Nutrition struct contains info about nutrition of the recipe
  Nutrition = Struct.new :fat, :carbs, :protein, :calories

  def initialize(fat = 'not provided', carbs = 'not provided',
                 protein = 'not provided')
    @feedback = Feedback.new
    @servings = 1
    @ingredients = []
    @nutrition = Nutrition.new(fat, carbs, protein, 'not provided')
  end

  def change_servings(servings)
    raise 'Only numbers allowed!' unless servings.instance_of? Integer
    @servings = servings
  end

  def calculate_calories
    nutrition.fat * 9 + (nutrition.carbs + nutrition.protein) * 4
  end

  def add_ingredient(name, amount, unit)
    ingredients.push(Ingredient.new(name, amount, unit))
  end

  def adjust_ingredients
    ingredients.map! do |item|
      item.amount *= servings
      item
    end
  end

  def adjust_nutrition
    nutrition.fat *= servings
    nutrition.carbs *= servings
    nutrition.protein *= servings
  end

  def display_average_rating
    puts feedback.average_rating
  end
end
