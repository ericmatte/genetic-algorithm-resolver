module Genetic
  module Algorithm
    # A member of a given population
    class Chromosome
      attr_reader :genes
      attr_reader :fitness

      def initialize(genes, fitness_calculator)
        @genes = genes
        @fitness = fitness_calculator.call(genes)
      end

      # Randomly change one of its gene.
      # Help maintain diversity within the population and prevent premature convergence.
      def mutate(genes_generator)
        i = rand(0..(genes.length - 1))
        @genes[i] = genes_generator.call(i)
      end
    end
  end
end
