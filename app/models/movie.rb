class Movie < ActiveRecord::Base
#Note that ratings is a class method here rather than instance method
  def Movie.ratings
      return Movie.select(:rating).map(&:rating).uniq
  end
end
