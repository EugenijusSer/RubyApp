RSpec::Matchers.define :be_a_recipe do
  match do |recipe|
    recipe.servings == 1 &&
      recipe.ingredients.any? &&
      recipe.nutrition.each do |item|
        return false if item.to_f < 0
      end
  end
end
