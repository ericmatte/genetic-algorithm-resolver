require "test_helper"

class Genetic::Algorithm::VersionTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil Genetic::Algorithm::VERSION
  end
end
