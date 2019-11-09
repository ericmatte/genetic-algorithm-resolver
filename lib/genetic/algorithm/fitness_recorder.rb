# Record and display best individuals accross generations
class Genetic::Algorithm::FitnessRecorder
  attr_reader :best_individual

  def initialize
    @best_individual = nil
    @best_individual_generation = nil
    @max_fitness = []
    @max_overall_finess = []
    @average_fitness = []
  end

  def record_generation(generation, population)
    best_generation_individual = population.max_by(&:fitness)

    # Save the best individual across all generations
    if best_generation_individual.fitness > @best_individual&.fitness
      @best_individual = best_generation_individual
      @best_individual_generation = generation
    end

    # Record progress information across all generations
    @max_fitness << best_generation_individual.fitness
    @max_overall_finess << @best_individual.fitness
    average = population.map(&:fitness).inject(:+) / population.length
    @average_fitness << average

    puts "Generation #{generation} completed."
    puts "    Best overall fitness: #{@best_individual.fitness}"
    puts "    Best population fitness: #{best_generation_individual.fitness}"
    puts "    Average population fitness: #{average}"
  end

  def display_best_individual
    puts "\n"
    puts "Result: The best overall individual was found on generation #{@best_individual_generation} with:"
    puts "    Fitness: #{@best_individual.fitness}"
    puts "    Genes: #{@best_individual.fitness}"
    puts "\n---\n"
    puts "Generations evlotion:"
    puts "#{@max_fitness.each_with_index.map { |_, i| i }},"
    puts "#{@max_fitness},"
    puts "#{@max_overall_finess},"
    puts "#{@average_fitness},"
  end

  def save_best_individual_genes
    raise "not implemented".freeze
  end
end
