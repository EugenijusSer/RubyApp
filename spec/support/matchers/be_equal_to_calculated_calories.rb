RSpec::Matchers.define(
  :be_equal_to_calculated_calories
) do |fat, carbs, protein|
  match do |sum|
    fat * 9 + (carbs + protein) * 4 == sum
  end
end
