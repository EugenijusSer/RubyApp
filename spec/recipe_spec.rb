require 'spec_helper'

describe Recipe do
  before do
    @recipe = described_class.new
  end
  let(:recipe) { described_class.new }

  context 'servings' do
    it 'set to 1 after creating' do
      expect(recipe.servings).to be(1)
    end

    it 'can be changed' do
      expect(recipe.change_servings(3)).to be(3)
    end

    it 'raises error when trying to change to not a number' do
      expect { recipe.change_servings('a') }.to raise_error(
        'Only numbers allowed!'
      )
    end

    it 'can adjust ingredients according to servings' do
      recipe.add_ingredient('cereal', 200, 'g')
      recipe.change_servings(4)
      recipe.adjust_ingredients
      expect(recipe.ingredients[0].amount).to be(800)
    end

    it 'can adjust nutrition according to servings' do
      recipe = described_class.new(20, 55, 15)
      recipe.change_servings(3)
      recipe.adjust_nutrition
      expect(recipe.nutrition.calories = recipe.calculate_calories).to be(1380)
    end
  end

  context 'feedback' do
    it 'average rating can be displayed' do
      expect { recipe.display_average_rating }.to output("0\n").to_stdout
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
      expect(recipe.nutrition.calories = recipe.calculate_calories).to be(
        109
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
