defmodule ApiWeb.SubscriptionController do
  use ApiWeb, :controller

  use Api.Accounts
  alias Api.Accounts.Subscription

  action_fallback ApiWeb.FallbackController

  def index(conn, _params) do
    subscription = list_subscription( )
    render(conn, "index.json", subscription: subscription)
  end

  def create(conn, %{"subscription" => subscription_params}) do
    with {:ok, %Subscription{} = subscription} <- create_subscription(subscription_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.subscription_path(conn, :show, subscription))
      |> render("show.json", subscription: subscription)
    end
  end

  def show(conn, %{"id" => id}) do
    subscription = get_subscription!(id)
    render(conn, "show.json", subscription: subscription)
  end

  def update(conn, %{"id" => id, "subscription" => subscription_params}) do
    subscription = get_subscription!(id)

    with {:ok, %Subscription{} = subscription} <- update_subscription(subscription, subscription_params) do
      render(conn, "show.json", subscription: subscription)
    end
  end

  def delete(conn, %{"id" => id}) do
    subscription = get_subscription!(id)

    with {:ok, %Subscription{}} <- delete_subscription(subscription) do
      send_resp(conn, :no_content, "")
    end
  end
end
