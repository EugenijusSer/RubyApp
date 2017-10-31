RSpec::Matchers.define(
  :have_correct_nutrition
) do |exp_fat, exp_carbs, exp_protein|
  match do |recipe|
    recipe.nutrition.fat == exp_fat &&
      recipe.nutrition.carbs == exp_carbs &&
      recipe.nutrition.protein == exp_protein
  end
end
