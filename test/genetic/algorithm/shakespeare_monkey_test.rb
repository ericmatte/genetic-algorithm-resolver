require "test_helper"

class Genetic::Algorithm::ShakespeareMonkeyTest < Minitest::Test
  def test_that_it_resolves_the_monkey_problem
    ga_optimizer = Genetic::Algorithm::Optimizer.new
    ga_optimizer.population_size = 200
    ga_optimizer.crossover_probability = 0.7
    ga_optimizer.mutation_probability = 0.5
    ga_optimizer.genes_generator = method(:genes_generator)
    ga_optimizer.fitness_calculator = method(:fitness_calculator)

    goal_phrase = goal.join

    generation = 0
    last_population = nil
    while generation < 500
      new_population = ga_optimizer.execute(last_population)

      best_one = new_population.max_by(&:fitness)
      best_phrase = best_one.genes.join

      if best_phrase == goal_phrase
        puts "Goal found! \"#{goal_phrase}\" in #{generation} generations."
        break
      else
        puts "#{best_phrase} - #{best_one.fitness * 100}% (G-#{generation})"
      end

      generation += 1
      last_population = new_population
    end

    assert(true, generation < 500)
  end

  private

  def goal
    "Make Time Count.".split("")
  end

  def letters
    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.!? ".split("")
  end

  def genes_generator(index = nil)
    index.nil? ? Array.new(goal.length) { letters.sample } : letters.sample
  end

  def fitness_calculator(genes)
    fitness = 0.0
    goal.each_with_index do |letter, i|
      fitness += 1 if letter == genes[i]
    end
    fitness / goal.length
  end
end
