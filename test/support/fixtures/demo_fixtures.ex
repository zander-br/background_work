defmodule BackgroundWork.DemoFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BackgroundWork.Demo` context.
  """

  @doc """
  Generate a pokemon.
  """
  def pokemon_fixture(attrs \\ %{}) do
    {:ok, pokemon} =
      attrs
      |> Enum.into(%{
        height: 42,
        name: "some name",
        weight: 42
      })
      |> BackgroundWork.Demo.create_pokemon()

    pokemon
  end
end
