defmodule BackgroundWork.DemoTest do
  use BackgroundWork.DataCase

  alias BackgroundWork.Demo

  describe "pokemons" do
    alias BackgroundWork.Demo.Pokemon

    import BackgroundWork.DemoFixtures

    @invalid_attrs %{height: nil, name: nil, weight: nil}

    test "list_pokemons/0 returns all pokemons" do
      pokemon = pokemon_fixture()
      assert Demo.list_pokemons() == [pokemon]
    end

    test "get_pokemon!/1 returns the pokemon with given id" do
      pokemon = pokemon_fixture()
      assert Demo.get_pokemon!(pokemon.id) == pokemon
    end

    test "create_pokemon/1 with valid data creates a pokemon" do
      valid_attrs = %{height: 42, name: "some name", weight: 42}

      assert {:ok, %Pokemon{} = pokemon} = Demo.create_pokemon(valid_attrs)
      assert pokemon.height == 42
      assert pokemon.name == "some name"
      assert pokemon.weight == 42
    end

    test "create_pokemon/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Demo.create_pokemon(@invalid_attrs)
    end

    test "update_pokemon/2 with valid data updates the pokemon" do
      pokemon = pokemon_fixture()
      update_attrs = %{height: 43, name: "some updated name", weight: 43}

      assert {:ok, %Pokemon{} = pokemon} = Demo.update_pokemon(pokemon, update_attrs)
      assert pokemon.height == 43
      assert pokemon.name == "some updated name"
      assert pokemon.weight == 43
    end

    test "update_pokemon/2 with invalid data returns error changeset" do
      pokemon = pokemon_fixture()
      assert {:error, %Ecto.Changeset{}} = Demo.update_pokemon(pokemon, @invalid_attrs)
      assert pokemon == Demo.get_pokemon!(pokemon.id)
    end

    test "delete_pokemon/1 deletes the pokemon" do
      pokemon = pokemon_fixture()
      assert {:ok, %Pokemon{}} = Demo.delete_pokemon(pokemon)
      assert_raise Ecto.NoResultsError, fn -> Demo.get_pokemon!(pokemon.id) end
    end

    test "change_pokemon/1 returns a pokemon changeset" do
      pokemon = pokemon_fixture()
      assert %Ecto.Changeset{} = Demo.change_pokemon(pokemon)
    end
  end
end
