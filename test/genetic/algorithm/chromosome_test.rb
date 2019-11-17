require "test_helper"
require "genetic/algorithm/chromosome"

class Genetic::Algorithm::ChromosomeTest < Minitest::Test
  def test_it_can_mutate_floats
    20.times do
      test_genes = Array.new(rand(1..20)) { rand(0..100) }
      test_ranges = Array.new(test_genes.length) do |i|
        el = test_genes[i].to_f
        [rand(el - 50.0..el), rand(el..el + 50.0)]
      end

      chromosome = Genetic::Algorithm::Chromosome.new(fitness: nil, genes: test_genes.dup)
      chromosome.mutate(test_ranges)

      number_of_mutated_genes = 0
      chromosome.genes.each_with_index do |el, i|
        if el != test_genes[i]
          number_of_mutated_genes += 1
        end

        assert(test_ranges[i][0] < el && el < test_ranges[i][1])
      end
      assert_equal(1, number_of_mutated_genes)
    end
  end

  def test_it_can_mutate_with_data_range
    test_ranges = [%w[male female], [18, 19, 20, 21, 22], ["🔥", "❄️", "🌎", "💨"]]
    test_genes = Array.new(test_ranges.length) { |i| test_ranges[i][0] }

    chromosome = Genetic::Algorithm::Chromosome.new(fitness: nil, genes: test_genes.dup)
    20.times do |i| # Discrete mutations can sometimes return the same value
      assert(false, "Unable to mutate") if i == 20
      chromosome.mutate(test_ranges, true)
      break if chromosome.genes != test_genes
    end

    number_of_mutated_genes = 0
    chromosome.genes.each_with_index do |el, i|
      if el != test_genes[i]
        number_of_mutated_genes += 1
      end

      assert((test_ranges[i].include? el))
    end
    assert_equal(1, number_of_mutated_genes)
  end
end
