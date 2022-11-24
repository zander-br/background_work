defmodule BackgroundWorkWeb.PokemonController do
  use BackgroundWorkWeb, :controller

  alias BackgroundWork.Demo
  alias BackgroundWork.Demo.Pokemon

  action_fallback BackgroundWorkWeb.FallbackController

  def index(conn, _params) do
    pokemons = Demo.list_pokemons()
    render(conn, "index.json", pokemons: pokemons)
  end

  def create(conn, %{"pokemon" => pokemon_params}) do
    with {:ok, %Pokemon{} = pokemon} <- Demo.create_pokemon(pokemon_params) do
      conn
      |> put_status(:created)
      |> render("show.json", pokemon: pokemon)
    end
  end

  def show(conn, %{"id" => id}) do
    pokemon = Demo.get_pokemon!(id)
    render(conn, "show.json", pokemon: pokemon)
  end

  def update(conn, %{"id" => id, "pokemon" => pokemon_params}) do
    pokemon = Demo.get_pokemon!(id)

    with {:ok, %Pokemon{} = pokemon} <- Demo.update_pokemon(pokemon, pokemon_params) do
      render(conn, "show.json", pokemon: pokemon)
    end
  end

  def delete(conn, %{"id" => id}) do
    pokemon = Demo.get_pokemon!(id)

    with {:ok, %Pokemon{}} <- Demo.delete_pokemon(pokemon) do
      send_resp(conn, :no_content, "")
    end
  end
end
