defmodule BackgroundWork.Demo do
  @moduledoc """
  The Demo context.
  """

  import Ecto.Query, warn: false
  alias BackgroundWork.Repo

  alias BackgroundWork.Demo.Pokemon
  alias BackgroundWork.PokemonDetailSupervisor

  @doc """
  Returns the list of pokemons.

  ## Examples

      iex> list_pokemons()
      [%Pokemon{}, ...]

  """
  def list_pokemons do
    Repo.all(Pokemon)
  end

  @doc """
  Gets a single pokemon.

  Raises `Ecto.NoResultsError` if the Pokemon does not exist.

  ## Examples

      iex> get_pokemon!(123)
      %Pokemon{}

      iex> get_pokemon!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pokemon!(id), do: Repo.get!(Pokemon, id)

  @doc """
  Creates a pokemon.

  ## Examples

      iex> create_pokemon(%{field: value})
      {:ok, %Pokemon{}}

      iex> create_pokemon(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pokemon(attrs \\ %{}) do
    {:ok, %Pokemon{name: name} = pokemon} =
      %Pokemon{}
      |> Pokemon.changeset(attrs)
      |> Repo.insert()

    PokemonDetailSupervisor.get_pokemon_detail(name)

    {:ok, pokemon}
  end

  @doc """
  Updates a pokemon.

  ## Examples

      iex> update_pokemon(pokemon, %{field: new_value})
      {:ok, %Pokemon{}}

      iex> update_pokemon(pokemon, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pokemon(%Pokemon{} = pokemon, attrs) do
    pokemon
    |> Pokemon.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a pokemon.

  ## Examples

      iex> delete_pokemon(pokemon)
      {:ok, %Pokemon{}}

      iex> delete_pokemon(pokemon)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pokemon(%Pokemon{} = pokemon) do
    Repo.delete(pokemon)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pokemon changes.

  ## Examples

      iex> change_pokemon(pokemon)
      %Ecto.Changeset{data: %Pokemon{}}

  """
  def change_pokemon(%Pokemon{} = pokemon, attrs \\ %{}) do
    Pokemon.changeset(pokemon, attrs)
  end
end
