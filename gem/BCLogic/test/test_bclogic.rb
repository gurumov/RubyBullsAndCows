require 'test/unit'
require 'lib/BCLogic'

class BCLogicTest < Test::Unit::TestCase
  def test_valid_number
    assert_true, BCLogic.valid? 1234
  end
end