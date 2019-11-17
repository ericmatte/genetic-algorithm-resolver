module Genetic
  module Algorithm
    class Optimizer
      attr_accessor :crossover_probability # Int
      attr_accessor :mutation_probability  # Int
      attr_accessor :population_size       # Int
      attr_accessor :genes_generator       # (index: Int?) -> Array<Gene> | Gene if index.nil?
      attr_accessor :fitness_calculator    # (genes: Array<Gene>) -> Int

      def execute(population = nil)
        population = initialize_population if population.nil?
        do_natural_selection(population)
      end

      private

      def initialize_population
        population = []
        @population_size.times.each do
          population << Chromosome.new(@genes_generator.call, @fitness_calculator)
        end
        population
      end

      def do_natural_selection(population)
        total_fitness = population.map(&:fitness).inject(:+)

        new_population = []
        (@population_size / 2).times.each do
          parent1 = weighted_random_sampling(population, total_fitness)
          parent2 = weighted_random_sampling(population - [parent1], total_fitness)

          child1, child2 = mate(parent1, parent2)

          new_population << child1
          new_population << child2
        end

        new_population
      end

      def weighted_random_sampling(population, total_fitness)
        if total_fitness.zero?
          population.sample
        else
          population.max_by { |chromosome| rand * (chromosome.fitness / total_fitness) }
        end
      end

      def mate(parent1, parent2)
        # crossover
        if rand < @crossover_probability
          i = rand(1..parent1.genes.length - 1)
          child1 = Chromosome.new(parent1.genes[0..i - 1] + parent2.genes[i..-1], @fitness_calculator)
          child2 = Chromosome.new(parent2.genes[0..i - 1] + parent1.genes[i..-1], @fitness_calculator)
        else
          child1 = Chromosome.new(parent1.genes.dup, @fitness_calculator)
          child2 = Chromosome.new(parent2.genes.dup, @fitness_calculator)
        end

        # mutation
        if rand < @mutation_probability
          child1.mutate(@genes_generator)
          child2.mutate(@genes_generator)
        end

        [child1, child2]
      end
    end
  end
end
