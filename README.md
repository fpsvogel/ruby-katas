# Ruby Katas

A collection of Ruby katas and suggested solutions.

Eventually I'll make this into a website, but for now this repo is a toolkit for developing the collection of katas, along with their tests and example solutions.

## Installation

```
$ git clone https://github.com/fpsvogel/ruby-katas.git
$ cd ruby-katas
$ bundle install
```

## Running the tests

Substitute `gilded-rose` below for the directory of the kata whose tests you want to run.

### Against a kata's example solution (example.rb)

```
$ rake test gilded-rose
```

Or simply:

```
$ rake gilded-rose
```

### Against a kata's starting code (start.rb)

```
$ rake test:start gilded-rose
```

Or simply:

```
$ rake start gilded-rose
```
