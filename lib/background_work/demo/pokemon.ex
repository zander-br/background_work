defmodule BackgroundWork.Demo.Pokemon do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "pokemons" do
    field :height, :integer
    field :name, :string
    field :weight, :integer

    timestamps()
  end

  @doc false
  def changeset(pokemon, attrs) do
    pokemon
    |> cast(attrs, [:name, :height, :weight])
    |> validate_required([:name])
  end
end
