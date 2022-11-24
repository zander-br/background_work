defmodule BackgroundWork.PokemonDetailSupervisor do
  alias BackgroundWork.Service.Pokemon

  def get_pokemon_detail(name) do
    opts = [restart: :transient]

    Task.Supervisor.start_child(__MODULE__, Pokemon, :update_pokemon_detail, [name], opts)
  end
end
