require "test_helper"
require "genetic/algorithm/optimizer"

class Genetic::Algorithm::OptimizerTest < Minitest::Test
  def test_it_initialize_population
    ga_optimizer = Genetic::Algorithm::Optimizer.new
    ga_optimizer.population_size = population_size
    ga_optimizer.genes_generator = method(:genes_generator)
    ga_optimizer.fitness_calculator = method(:fitness_calculator)

    test_population = ga_optimizer.send(:initialize_population)

    assert(test_population.length == population_size)
    assert(test_population.map(&:fitness).inject(:+) >= population_size)
  end

  def test_it_do_natural_selection
    ga_optimizer = Genetic::Algorithm::Optimizer.new
    ga_optimizer.crossover_probability = 0.7
    ga_optimizer.mutation_probability = 0.5
    ga_optimizer.population_size = population_size
    ga_optimizer.genes_generator = method(:genes_generator)
    ga_optimizer.fitness_calculator = method(:fitness_calculator)
    first_population = ga_optimizer.send(:initialize_population)
    last_population = first_population

    100.times do
      last_population = ga_optimizer.send(:do_natural_selection, last_population)
    end

    assert(first_population.length == population_size)
    assert(last_population.length == population_size)

    assert(first_population != last_population)
    first_gen_fitness = first_population.map(&:fitness).inject(:+)
    last_gen_fitness = last_population.map(&:fitness).inject(:+)
    assert(first_gen_fitness != last_gen_fitness)
  end

  def test_mate_with_0_proability_returns_same_chromosomes
    ga_optimizer = Genetic::Algorithm::Optimizer.new
    ga_optimizer.crossover_probability = 0.0
    ga_optimizer.mutation_probability = 0.0
    ga_optimizer.genes_generator = method(:genes_generator)
    ga_optimizer.fitness_calculator = method(:fitness_calculator)

    parent1 = Genetic::Algorithm::Chromosome.new(genes_generator, method(:fitness_calculator))
    parent2 = Genetic::Algorithm::Chromosome.new(genes_generator, method(:fitness_calculator))
    child1, child2 = ga_optimizer.send(:mate, parent1, parent2)

    assert(parent1.genes != parent2.genes)
    assert(child1.genes == parent1.genes)
    assert(child2.genes == parent2.genes)
  end

  def test_mate_crossover
    ga_optimizer = Genetic::Algorithm::Optimizer.new
    ga_optimizer.crossover_probability = 1.0
    ga_optimizer.mutation_probability = 0.0
    ga_optimizer.genes_generator = method(:genes_generator)
    ga_optimizer.fitness_calculator = method(:fitness_calculator)

    parent1 = Genetic::Algorithm::Chromosome.new(genes_generator, method(:fitness_calculator))
    parent2 = Genetic::Algorithm::Chromosome.new(genes_generator, method(:fitness_calculator))
    child1, child2 = ga_optimizer.send(:mate, parent1, parent2)

    assert(parent1.genes != parent2.genes)
    assert(child1.genes != parent1.genes)
    assert(child2.genes != parent2.genes)
  end

  def test_mate_make_one_mutation_per_child
    ga_optimizer = Genetic::Algorithm::Optimizer.new
    ga_optimizer.crossover_probability = 0.0
    ga_optimizer.mutation_probability = 1.0
    ga_optimizer.genes_generator = method(:genes_generator)
    ga_optimizer.fitness_calculator = method(:fitness_calculator)

    parent1 = Genetic::Algorithm::Chromosome.new(genes_generator, method(:fitness_calculator))
    parent2 = Genetic::Algorithm::Chromosome.new(genes_generator, method(:fitness_calculator))
    child1, child2 = ga_optimizer.send(:mate, parent1, parent2)

    assert(parent1.genes != parent2.genes)
    assert(child1.genes != parent1.genes)
    assert(child2.genes != parent2.genes)

    number_of_mutations = 0
    child1.genes.each_with_index { |g, i| number_of_mutations += 1 if g != parent1.genes[i] }
    child2.genes.each_with_index { |g, i| number_of_mutations += 1 if g != parent2.genes[i] }
    assert(number_of_mutations == 2)
  end

  private

  def population_size
    50
  end

  def genes_generator(index = nil)
    random_genes = Array.new(5) { rand(1..100) }
    index.nil? ? random_genes : random_genes[index]
  end

  def fitness_calculator(genes)
    genes.inject(:+)
  end
end
