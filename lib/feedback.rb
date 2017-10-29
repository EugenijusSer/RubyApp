# This class is responsible for dealing with feedback (rating and coments)
class Feedback
  attr_reader :ratings, :average_rating, :comments

  def initialize
    @ratings = []
    @average_rating = 0
    @comments = []
  end

  def add_rating(rating)
    ratings.push(rating)
  end

  def add_comment(comment)
    comments.push(comment)
  end

  def calculate_average_rating
    (ratings.inject(0.0) { |sum, el| sum + el } / ratings.size).round(1)
  end
end
