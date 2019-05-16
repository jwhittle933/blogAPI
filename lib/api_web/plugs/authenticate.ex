defmodule ApiWeb.Plug.Authenticate do
  import Plug.Conn
  alias Api.Accounts

  def init(params), do: params

  def call(conn, _params) do
    with current_user_id when not is_nil(current_user_id) <- get_session(conn, :current_user_id),
      user when not is_nil(user) <- Accounts.get_user!(current_user_id) do
      conn
      |> configure_session(renew: true)
      |> set_current_user(user)
    else
      nil ->
        conn
        |> put_status(:unauthorized)
        |> send_resp(401, "Unauthorized")
        |> halt
    end
  end

  defp set_current_user(conn, %{id: _, name: _} = user) do
    conn
    |> assign(:current_user, user)
    |> assign(:user_signed_in?, true)
  end
end
