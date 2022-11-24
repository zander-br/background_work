defmodule BackgroundWorkWeb.PokemonView do
  use BackgroundWorkWeb, :view
  alias BackgroundWorkWeb.PokemonView

  def render("index.json", %{pokemons: pokemons}) do
    %{data: render_many(pokemons, PokemonView, "pokemon.json")}
  end

  def render("show.json", %{pokemon: pokemon}) do
    %{data: render_one(pokemon, PokemonView, "pokemon.json")}
  end

  def render("pokemon.json", %{pokemon: pokemon}) do
    %{
      id: pokemon.id,
      name: pokemon.name,
      height: pokemon.height,
      weight: pokemon.weight
    }
  end
end
