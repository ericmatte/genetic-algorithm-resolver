require "test_helper"
require "genetic/algorithm/chromosome"

class Genetic::Algorithm::ChromosomeTest < Minitest::Test
  def test_it_can_mutate_with_data_range
    test_ranges = [%w[male female], [18, 19, 20, 21, 22], ["🔥", "❄️", "🌎", "💨"]]
    genes_generator = proc do |index = nil|
      index.nil? ? Array.new(test_ranges.length) { |i| test_ranges[i][0] } : test_ranges[index].sample
    end
    test_genes = genes_generator.call

    chromosome = Genetic::Algorithm::Chromosome.new(test_genes.dup, method(:fitness_calculator))
    20.times do |i| # Discrete mutations can sometimes return the same value
      assert(false, "Unable to mutate") if i == 20
      chromosome.mutate(genes_generator)
      break if chromosome.genes != test_genes
    end

    number_of_mutated_genes = 0
    chromosome.genes.each_with_index do |el, i|
      number_of_mutated_genes += 1 if el != test_genes[i]
      assert(test_ranges[i].include?(el))
    end
    assert_equal(1, number_of_mutated_genes)
  end

  private

  def fitness_calculator(_genes)
    1
  end
end
