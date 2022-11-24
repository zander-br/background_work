defmodule BackgroundWork.Service.Pokemon do
  import Ecto.Query

  alias Adapter.Pokemon, as: PokemonAdapter
  alias BackgroundWork.Demo.Pokemon
  alias BackgroundWork.Repo

  def update_pokemon_detail(name) do
    IO.inspect("Chamou a atualização do Pokemon")
    Process.sleep(30_000)

    IO.inspect("Irá realizar a consulta")

    pokemon = get_pokemon_by_name(name)
    details = PokemonAdapter.pokemon_details(name)

    pokemon
    |> Pokemon.changeset(details)
    |> Repo.update()
    |> IO.inspect()
  end

  defp get_pokemon_by_name(name) do
    query = from pokemon in Pokemon, where: pokemon.name == ^name
    Repo.one!(query)
  end
end
