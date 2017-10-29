require 'spec_helper'

describe Feedback do
  before do
    @feedback = described_class.new
  end
  let(:feedback) { described_class.new }

  context 'rating' do
    it 'average rating has initial 0 value' do
      expect(feedback.average_rating).to be(0)
    end

    it 'can be added to ratings list' do
      feedback.add_rating(3)
      expect(feedback.ratings[0]).to be(3)
    end

    it 'average rating can be calculated' do
      feedback.add_rating(1)
      feedback.add_rating(3)
      feedback.add_rating(3)
      expect(feedback.calculate_average_rating).to be(2.3)
    end
  end

  context 'comment' do
    it 'can be added to comments list' do
      feedback.add_comment('Nice recipe')
      expect(feedback.comments[0]).to eql('Nice recipe')
    end
  end
end
