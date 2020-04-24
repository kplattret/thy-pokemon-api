# Thy Pokémon API

Simple API to get a description of a given Pokemon species, in Shakespearean English. In order to
achieve this, this application leverages the [PokéAPI](https://pokeapi.co) and the [Fun
Translations](https://funtranslations.com/api/shakespeare) API in turn.

Feel free to take a look at the [documentation](documentation.md).

## Installation and tests

This application can be built and served locally using `Docker` by using the following commands:

**Run the app:** 

```shell
$ docker-compose up
```

**Run the test suite:**

```shell
$ docker-compose run web mix test
```
