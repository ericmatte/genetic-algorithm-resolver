# A member of a given population
class Genetic::Algorithm::Chromosome
  attr_accessor :genes
  attr_accessor :fitness

  def initialize(genes:, fitness:)
    @genes = genes
    @fitness = fitness
  end

  # Randomly change one of its gene.
  # Help maintain diversity within the population and prevent premature convergence.
  # @param [(Object | Float)[][]] ranges - The available ranges to mutate from for all genes. ranges.lenght must equals genes.length
  # @param [Boolean] sampleFromRanges
  #                  If true:  take one of the available values for a given range
  #                  if false: take a random floating value between ranges[i][0] and ranges[i][1]
  def mutate(ranges, sample_from_ranges = false)
    i = rand(0..(genes.length - 1))
    @genes[i] = sample_from_ranges ? ranges[i].sample : rand(ranges[i][0]..ranges[i][1])
  end
end
