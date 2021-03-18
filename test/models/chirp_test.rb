require "test_helper"

class ChirpTest < ActiveSupport::TestCase
  test "should not save chirp without text" do
    chirp = Chirp.new
    assert_not chirp.save
  end

  test "should not save chirp text over 140 characters" do
    text = (0...200).map { (65 + rand(26)).chr }.join
    chirp = Chirp.new(text: text)
    assert_not chirp.save
  end
end
