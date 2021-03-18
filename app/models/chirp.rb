class Chirp < ApplicationRecord

  validates :text, presence: true
  validates_length_of :text, :maximum => 140

  def upvote
    if self.votes.nil?
      self.votes = 1
    else
      self.votes += 1
    end
  end

  def downvote
    if self.votes.nil? || self.votes < 1
      self.votes = 0
    else
      self.votes -= 1
    end
  end
end
