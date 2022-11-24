defmodule BackgroundWorkWeb.Router do
  use BackgroundWorkWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BackgroundWorkWeb do
    pipe_through :api

    post("/pokemons", PokemonController, :create)
    get("/pokemons", PokemonController, :index)
  end
end
