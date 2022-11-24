defmodule BackgroundWorkWeb.PokemonControllerTest do
  use BackgroundWorkWeb.ConnCase

  import BackgroundWork.DemoFixtures

  alias BackgroundWork.Demo.Pokemon

  @create_attrs %{
    height: 42,
    name: "some name",
    weight: 42
  }
  @update_attrs %{
    height: 43,
    name: "some updated name",
    weight: 43
  }
  @invalid_attrs %{height: nil, name: nil, weight: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all pokemons", %{conn: conn} do
      conn = get(conn, Routes.pokemon_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create pokemon" do
    test "renders pokemon when data is valid", %{conn: conn} do
      conn = post(conn, Routes.pokemon_path(conn, :create), pokemon: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.pokemon_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "height" => 42,
               "name" => "some name",
               "weight" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.pokemon_path(conn, :create), pokemon: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update pokemon" do
    setup [:create_pokemon]

    test "renders pokemon when data is valid", %{conn: conn, pokemon: %Pokemon{id: id} = pokemon} do
      conn = put(conn, Routes.pokemon_path(conn, :update, pokemon), pokemon: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.pokemon_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "height" => 43,
               "name" => "some updated name",
               "weight" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, pokemon: pokemon} do
      conn = put(conn, Routes.pokemon_path(conn, :update, pokemon), pokemon: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete pokemon" do
    setup [:create_pokemon]

    test "deletes chosen pokemon", %{conn: conn, pokemon: pokemon} do
      conn = delete(conn, Routes.pokemon_path(conn, :delete, pokemon))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.pokemon_path(conn, :show, pokemon))
      end
    end
  end

  defp create_pokemon(_) do
    pokemon = pokemon_fixture()
    %{pokemon: pokemon}
  end
end
