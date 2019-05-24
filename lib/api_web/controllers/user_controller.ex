defmodule ApiWeb.UserController do
  use ApiWeb, :controller

  use Api.Accounts
  alias Api.Accounts.User

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    users = list_users()
    conn
    |> put_status(:ok)
    |> put_resp_header("content-type", "application/json")
    |> json(%{users: users})
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("content-type", "application/json")
      |> send_resp(200, user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = get_user(id)
    json(conn, %{user: user})
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = get_user(id)

    with {:ok, %User{} = user} <- update_user(user, user_params) do
      json(conn, %{user: user})
    end
  end

  def delete(conn, %{"id" => id}) do
    user = get_user(id)

    with {:ok, %User{}} <- delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def author(conn, _params) do
  end

  def authors(conn, _params) do
    authors = get_list_authors()
    conn
    |> put_status(:ok)
    |> put_resp_header("content-type", "application/json")
    |> json(%{authors: authors})
  end

  defp get_single_author do

  end

  defp get_list_authors do
    %{name: name, id: id, bio: bio} = list_users()
  end
end
