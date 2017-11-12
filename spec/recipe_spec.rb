require 'spec_helper'

describe Recipe do
  let(:recipe) { described_class.new }
  let(:new_recipe) { described_class.new(20, 55, 15) }

  context 'create' do
    it 'recipe can be created' do
      recipe = described_class.new(5, 200, 50)
      recipe.add_ingredient('rice', 200, 'g')
      expect(recipe).to be_a_recipe
    end
  end

  context 'servings' do
    it 'set to 1 after creating' do
      expect(recipe.servings).to be(1)
    end

    it 'can be changed' do
      expect(recipe.change_servings(3)).to be(3)
    end

    it 'raises error when trying to change to not a number' do
      expect { recipe.change_servings('a') }.to raise_error(
        ArgumentError, 'Only numbers allowed!'
      )
    end

    it 'can adjust ingredients according to servings' do
      recipe.add_ingredient('cereal', 200, 'g')
      recipe.change_servings(4)
      recipe.adjust_ingredients
      expect(recipe.ingredients[0].amount).to be(800)
    end

    it 'can adjust nutrition according to servings' do
      new_recipe.change_servings(3)
      new_recipe.adjust_nutrition
      expect(new_recipe.calculate_calories).to be_equal_to_calculated_calories(
        60, 165, 45
      )
    end
  end

  context 'feedback' do
    it 'average rating can be displayed' do
      recipe.feedback.add_rating(5)
      recipe.feedback.add_rating(1)
      expect { recipe.display_average_rating }.to output("3.0\n").to_stdout
    end
  end

  context 'nutrition' do
    it 'displays "not provided" instead of macronutrients
        if they are not specified on create' do
      expect(recipe.nutrition).to have_attributes(
        fat: 'not provided', carbs: 'not provided',
        protein: 'not provided', calories: 'not provided'
      )
    end

    it 'sets macronutrients if they are specified on create' do
      recipe = described_class.new(30, 45, 25)
      expect(recipe.nutrition).to have_attributes(
        fat: 30, carbs: 45, protein: 25
      )
    end

    it 'can calculate calories' do
      recipe = described_class.new(5, 7, 9)
      expect(recipe.calculate_calories).to be_equal_to_calculated_calories(
        5, 7, 9
      )
    end
  end

  context 'ingredient' do
    before do
      recipe.add_ingredient('milk', 300, 'ml')
    end

    it 'can be added to ingredients list' do
      expect(recipe.ingredients[0]).to have_attributes(
        name: 'milk', amount: 300, unit: 'ml'
      )
    end
  end
end
