defmodule Api.SubscriptionsTest do

  use Api.DataCase
  alias Api.Accounts

   describe "subscription" do
    alias Api.Accounts.Subscription

    @valid_attrs %{
      email: "some email",
      name: "some name"
    }
    @update_attrs %{
      email: "some updated email",
      name: "some updated name"
    }
    @invalid_attrs %{email: nil, name: nil}

    def subscription_fixture(attrs \\ %{}) do
      {:ok, subscription} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_subscription()

      subscription
    end

    test "list_subscription/0 returns all subscription" do
      subscription = subscription_fixture()
      assert Accounts.list_subscription() == [subscription]
    end

    test "get_subscription!/1 returns the subscription with given id" do
      subscription = subscription_fixture()
      assert Accounts.get_subscription!(subscription.id) == subscription
    end

    test "create_subscription/1 with valid data creates a subscription" do
      assert {:ok, %Subscription{} = subscription} = Accounts.create_subscription(@valid_attrs)
      assert subscription.email == "some email"
      assert subscription.name == "some name"
    end

    test "create_subscription/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_subscription(@invalid_attrs)
    end

    test "update_subscription/2 with valid data updates the subscription" do
      subscription = subscription_fixture()
      assert {:ok, %Subscription{} = subscription} = Accounts.update_subscription(subscription, @update_attrs)
      assert subscription.email == "some updated email"
      assert subscription.name == "some updated name"
    end

    test "update_subscription/2 with invalid data returns error changeset" do
      subscription = subscription_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_subscription(subscription, @invalid_attrs)
      assert subscription == Accounts.get_subscription!(subscription.id)
    end

    test "delete_subscription/1 deletes the subscription" do
      subscription = subscription_fixture()
      assert {:ok, %Subscription{}} = Accounts.delete_subscription(subscription)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_subscription!(subscription.id) end
    end

    test "change_subscription/1 returns a subscription changeset" do
      subscription = subscription_fixture()
      assert %Ecto.Changeset{} = Accounts.change_subscription(subscription)
    end
   end

end
