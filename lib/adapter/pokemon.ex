defmodule Adapter.Pokemon do
  use Tesla

  alias Tesla.Env

  plug Tesla.Middleware.BaseUrl, "https://pokeapi.co/api/v2/pokemon"
  plug Tesla.Middleware.JSON

  def pokemon_details(name) do
    "/#{name}"
    |> get()
    |> parse_response()
  end

  defp parse_response({:ok, %Env{body: %{"height" => height, "weight" => weight}}}),
    do: %{height: height, weight: weight}
end
