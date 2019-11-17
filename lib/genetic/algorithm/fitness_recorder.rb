# Record and display best individuals accross generations
class Genetic::Algorithm::FitnessRecorder
  attr_accessor :best_individual

  def initialize
    @best_individual = nil
    @max_fitness = []
    @max_overall_finess = []
    @average_fitness = []
  end

  def record_generation(generation, population)
    best_generation_individual = population.max_by(&:fitness)

    # Save best individual across all generations
    if best_generation_individual.fitness > (@best_individual&.fitness || -1e10)
      @best_individual = best_generation_individual
    end

    # Record progress information
    @max_fitness << best_generation_individual.fitness
    @max_overall_finess << @best_individual.fitness
    average = population.map(&:fitness).inject(:+) / population.length
    @average_fitness << average

    puts "Generation #{generation} completed."
    puts "    Best overall fitness: #{@best_individual.fitness}"
    puts "    Best population fitness: #{best_generation_individual.fitness}"
    puts "    Average population fitness: #{average}"
  end

  def display_best_individual(shifts)
    puts "\n"
    puts "Result: Best overall individual fitness: #{@best_individual.fitness}"
    puts "                                                     Shift\t->\tSelected employee:"
    print_shift = ->(shift) { "[#{shift.start_at.localtime} - #{shift.end_at.localtime}]: #{shift.position.name}" }
    print_employee = ->(employee) { "#{employee.profile.full_name} (#{employee.email})" }
    puts shifts.each_with_index.map { |s, i| "#{print_shift[s[:shift]]}\t->\t#{print_employee[@best_individual.genes[i].user]}" }

    # puts "#{@max_fitness.each_with_index.map { |_, i| i }},"
    # puts "#{@max_fitness},"
    # puts "#{@max_overall_finess},"
    # puts "#{@average_fitness},"
  end

  def save_best_individual_genes
    raise "not implemented".freeze
  end
end
