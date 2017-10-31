RSpec::Matchers.define(
  :have_correct_recipe_values
) do |exp_id, exp_name, exp_fat, exp_carbs, exp_protein|
  match do |recipe|
    recipe[:id] == exp_id &&
      recipe[:name] == exp_name &&
      recipe[:recipe].nutrition.fat == exp_fat &&
      recipe[:recipe].nutrition.carbs == exp_carbs &&
      recipe[:recipe].nutrition.protein == exp_protein
  end
end
