# Genetic::Algorithm::Resolver

A Ruby gem to solve optimisation problems using genetic Algorithm, inspired by the process of natural selection.

---

Here is a great article on the subject: [Introduction to Genetic Algorithms](https://towardsdatascience.com/introduction-to-genetic-algorithms-including-example-code-e396e98d8bf3)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'genetic-algorithm-resolver', git: "git@github.com:ericmatte/genetic-algorithm-resolver.git"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install genetic-algorithm-resolver

## Usage

1. Create a `genes_generator` function:

```ruby
def genes_generator(index = nil)
  if index.nil?
    # return a list of random genes with the chosen length of a chromosome.
  else
    # return only one random gene at the selected `index`.
  end
end
```

2. Create a `fitness_calculator` function:

```ruby
def fitness_calculator(genes)
  # return the fitness score of the given list of `genes`.
end
```

3. Init the optimizer and parameters

```ruby
ga_optimizer = Genetic::Algorithm::Optimizer.new
ga_optimizer.population_size = 200
ga_optimizer.crossover_probability = 0.7
ga_optimizer.mutation_probability = 0.5
ga_optimizer.genes_generator = method(:genes_generator)
ga_optimizer.fitness_calculator = method(:fitness_calculator)
```

4. `execute` in a loop for a given amount of generations, or until the problem is resolved:

```ruby
generation = 0
last_population = nil
while generation < 500
  new_population = ga_optimizer.execute(last_population)

  best_chromosome = new_population.max_by(&:fitness)

  if problem_is_solved(best_chromosome)
    puts "Goal found!"
    break
  end

  generation += 1
  last_population = new_population
end
```

### Example

[The Shakespeare Monkey Test](test/genetic/algorithm/shakespeare_monkey_test.rb)

## Development

### Setup

    $ bin/setup

### Test

    $ rake test

### Interactive prompt

Allow you to experiment with the code

    $ bin/console

### Debugging using VS-Code

Just start a debug session using the `debug-console` configuration in `launch.json`.
This will launch a ruby console on the project, and attaches VS-Code debugger to it.

---

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ericmatte/genetic-algorithm-resolver. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Genetic::Algorithm::Resolver project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ericmatte/genetic-algorithm-resolver/blob/master/CODE_OF_CONDUCT.md).
