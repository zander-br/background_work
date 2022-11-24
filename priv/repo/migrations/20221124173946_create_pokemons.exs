defmodule BackgroundWork.Repo.Migrations.CreatePokemons do
  use Ecto.Migration

  def change do
    create table(:pokemons, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :height, :integer
      add :weight, :integer

      timestamps()
    end
  end
end
