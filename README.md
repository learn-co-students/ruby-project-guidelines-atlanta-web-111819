# FoodLocker
FoodLocker is a recipe sharing Command Line Interface application. Users
can create recipes, save recipes by other users, and rate recipes.

FoodLocker is built in Ruby.

## Features

 * Users can create and edit recipes
 * Users can search for a recipe in the list of existing recipes
 * Users can print out the list of top rated recipes
 * Users can add a recipe to their list of saved recipes
 * Users can rate recipes that they save
 * Users can see most popular categories
 * Users can add a category of recipes to their favorites.
 * Users can change their names
 * Users can see the ratings of recipes they create
 * Users can remove saved recipes.

## Installation
Installation of FoodLocker is fairly straightforward
Start by cloning the repository.
```
git clone https://github.com/speratus/ruby-project-guidelines-atlanta-web-111819.git
```
Change directory into the repository. Then install all of the required gems.
```
bundle install
```
If you get an error saying that the command is unrecognized, try running the
following command first.
```
gem install bundler
```
You'll have to create the database. You can do this easily with:
```
rake db:migrate
```
If you want, you can add some starting recipes in.
```
rake db:seed
```
The seed file uses the `Faker` gem, so you will get nonsense results, but that can be
part of the fun.
That's all that's required. You should be ready to go!
in the working directory, open up terminal and run the following command to
start the CLI.
```
ruby bin/run.rb
```
## Contributing
You can contribute to FoodLocker by forking this repo and then submitting a pull
request once you are satisfied with your changes. In the description for your pull request, make sure to describe what changed and why it needed to be changed.

## License
[License](LICENSE.md)

